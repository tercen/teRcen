library(R6)
library(httr)
library(jsonlite)
library(rtson)
library(purrr)
library(dplyr)

AbstractOperatorContext <- R6Class(
  "AbstractOperatorContext", 
  private = list(
    .schema = NULL,
    .cschema = NULL,
    .rschema = NULL
  ),
  public = list(
    
    client = NULL, 
    task = NULL,
    
    select = function(names=list(), offset=0, nr=-1) {
      return (self$selectSchema(self$schema, names=names,offset=offset,nr=nr))
    },
    cselect = function(names=list(), offset=0, nr=-1) {
      return (self$selectSchema(self$cschema,names=names,offset=offset,nr=nr))
    },
    rselect = function(names=list(), offset=0, nr=-1) {
      return (self$selectSchema(self$rschema, names=names,offset=offset,nr=nr))
    },
    selectSchema = function(schema=NULL, names=list(), offset=0, nr=-1) {
      cnames = as.list(names)
      names(cnames) = NULL
      qtSchema = self$schema
      
      if (length(cnames) == 0){
        where = sapply(schema$columns, function(c) (c$type != 'uint64' && c$type != 'int64') )
        cnames = lapply(schema$columns[where], function(c) c$name)
      }
      
      nRows  = nr
      
      if (nRows < 0){
        nRows = schema$nRows - offset
      }
      
      table = self$client$tableSchemaService$select(schema$id, cnames, offset, nRows)
      df = as_tibble(table)
      
      return(df)
    },
    addNamespace = function(df){
      ns = self$namespace
      names(df) = names(df) %>% purrr::map(function(x){
        if (substr(x,1,1) == '.') return(x)
        return (paste0(ns,'.',x))
      })
      return(df)
    },
    log = function(message){
      taskId = self$taskId
      if (!is.null(taskId)){
        evt = TaskLogEvent$new()
        evt$message = message
        evt$taskId = taskId
        self$client$eventService$create(evt)
      }
    },
    progress = function(message, actual, total){
      taskId = self$taskId
      if (!is.null(taskId)){
        evt = TaskProgressEvent$new()
        evt$message = message
        evt$taskId = taskId
        evt$actual = actual
        evt$total = total
        self$client$eventService$create(evt)
      }
    }
  ),
  active = list(
    taskId = function(value) {
      if (!missing(value)) stop('read only')
      if (is.null(self$task)){
        return(NULL)
      }
      return (self$task$id)
    },
    schema = function(value) {
      if (!missing(value)) stop('read only')
      if (is.null(private$.schema)){
        private$.schema = self$client$tableSchemaService$findByQueryHash(keys=list(self$query$qtHash))[[1]]
      }
      return ( private$.schema )
    },
    cschema = function(value) {
      if (!missing(value)) stop('read only')
      if (is.null(private$.cschema)){
        private$.cschema = self$client$tableSchemaService$findByQueryHash(keys=list(self$query$columnHash))[[1]]
      }
      return ( private$.cschema )
    },
    rschema = function(value) {
      if (!missing(value)) stop('read only')
      if (is.null(private$.rschema)){
        private$.rschema = self$client$tableSchemaService$findByQueryHash(keys=list(self$query$rowHash))[[1]]
      }
      return ( private$.rschema )
    },
    namespace = function(value) {
      if (!missing(value)) stop('read only')
      return(self$query$operatorSettings$namespace)
    },
    names = function(value) {
      if (!missing(value)) stop('read only')
      ll = lapply(self$schema$columns, function(each) each$name)
      names(ll)=ll
      return(ll) 
    },
    cnames = function(value) {
      if (!missing(value)) stop('read only')
      ll = lapply(self$cschema$columns, function(each) each$name)
      names(ll)=ll
      return(ll) 
    },
    rnames = function(value) {
      if (!missing(value)) stop('read only')
      ll = lapply(self$rschema$columns, function(each) each$name)
      names(ll)=ll
      return(ll) 
    }
  )
)

OperatorContextDev <- R6Class(
  "OperatorContextDev", 
  inherit = AbstractOperatorContext,
  private = list(
    .query = NULL
  ),
  public = list(

    workflowId = NULL,
    stepId = NULL,
    
    initialize = function( workflowId=getOption("tercen.workflowId"),
                           stepId=getOption("tercen.stepId"),
                           taskId=NULL,
                           authToken=NULL, 
                           username = getOption("tercen.username"),
                           password = getOption("tercen.password"),
                           serviceUri=getOption("tercen.serviceUri", default = "https://tercen.com/service")) {
      
      self$client = TercenClient$new(authToken=authToken, username=username, password=password, serviceUri=serviceUri)
      
      self$workflowId = workflowId
      self$stepId = stepId
        
      if (!is.null(taskId)){
        self$task = self$client$taskService$get(taskId)
      }
    },
    save = function(computed.df){
      
      result = OperatorResult$new()
      result$tables = list(tercen::dataframe.as.table(computed.df))
      bytes = rtson::toTSON(result$toTson())
      
      workflow = self$workflow
      
      fileDoc = FileDocument$new()
      fileDoc$name = 'result'
      fileDoc$projectId = workflow$projectId
      fileDoc$acl$owner = workflow$acl$owner
      fileDoc$metadata$contentType = 'application/octet-stream'
        
      fileDoc = self$client$fileService$upload(fileDoc, bytes)
      
      # the task can be null if run from a R session
      if (is.null(self$task)){
        print('task is null, create a task')
        task = ComputationTask$new()
        task$state = InitState$new()
        task$projectId = workflow$projectId
        task$query = self$query
        task$fileResultId = fileDoc$id
        self$task = self$client$taskService$create(task)
      } else {
        self$task$fileResultId = fileDoc$id
        rev = self$client$taskService$update(self$task)
        self$task$rev = rev
      }
      
      self$client$taskService$runTask(self$task$id)
      
      self$task = self$client$taskService$waitDone(self$task$id)
      
      if (inherits(self$task$state, 'FailedState')){
        stop(self$task$state$reason)
      }
    }
  ),
  active = list(
    
    workflow = function(value){
      if (!missing(value)) stop('read only')
      return (self$client$workflowService$get(self$workflowId))
    },
    query = function(value) {
      if (!missing(value)) stop('read only')
      if (is.null(private$.query)){
        if (is.null(self$task)){
          private$.query = self$client$workflowService$getCubeQuery(self$workflowId, self$stepId)
        } else {
          private$.query = self$task$query
        }
      }
      return (private$.query)
    } 
  )
)

OperatorContext <- R6Class(
  "OperatorContext", 
  inherit = AbstractOperatorContext,
  private = list(
    .query = NULL
  ),
  public = list(
    client = NULL,

    initialize = function(taskId = NULL,
                          authToken = NULL, 
                          username = getOption("tercen.username"),
                          password = getOption("tercen.password"),
                          serviceUri = getOption("tercen.serviceUri", default = "https://tercen.com/service")) { 
      
      self$client = TercenClient$new(authToken=authToken, username=username, password=password, serviceUri=serviceUri)
      
      if (is.null(taskId)){
        self$task = self$client$taskService$get(parseCommandArgs()$taskId)
      } else {
        self$task = self$client$taskService$get(taskId)
      }
    },
    
    save = function(computed.df){
      
      result = OperatorResult$new()
      result$tables = list(tercen::dataframe.as.table(computed.df))
      bytes = rtson::toTSON(result$toTson())
      
      fileDoc = self$client$fileService$get(self$task$fileResultId)
      self$client$fileService$upload(fileDoc, bytes)
    }
  ),
  active = list(
    
    workflow = function(value){
      if (!missing(value)) stop('read only')
      stop('not inpl')
      #       return (self$client$workflowService$get(self$workflowId))
    },
    query = function(value) {
      if (!missing(value)) stop('read only')
      if (is.null(private$.query)){
        private$.query = self$task$query
      }
      return (private$.query)
    } 
  )
)
 
#' @export
tercenCtx <- function(workflowId=getOption("tercen.workflowId"),
                      stepId=getOption("tercen.stepId"), 
                      taskId = NULL,
                      authToken = NULL, 
                      username = getOption("tercen.username"), password = getOption("tercen.password"),
                      serviceUri = getOption("tercen.serviceUri", default = "https://tercen.com/service")){
 
  if (is.null(workflowId)){
    return (OperatorContext$new(taskId=taskId,
                                authToken=authToken,
                                username=username, 
                                password=password, 
                                serviceUri=serviceUri))
  } else {
    return (OperatorContextDev$new(workflowId=workflowId,
                                   stepId=stepId,
                                   taskId=taskId,
                                   authToken=authToken,
                                   username=username,
                                   password=password,
                                   serviceUri=serviceUri))
  }
}

#' @export
cselect <- function(ctx, ...){
  return (ctx$cselect(getNames(ctx$cnames, ...)))
}

#' @export
rselect <- function(ctx, ...){
  return (ctx$rselect(getNames(ctx$rnames, ...)))
}

#' @export
select.AbstractOperatorContext <- function(ctx, ...){
  return (ctx$select(getNames(ctx$names, ...)))
}

getNames = function(names, ...){
  dots = rlang::quos(...)
  ll = lapply(dots, function(x) rlang::eval_tidy(x, names ))
  return (unlist(ll))
}