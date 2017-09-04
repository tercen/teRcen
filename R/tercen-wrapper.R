library(R6)
library(httr)
library(jsonlite)
library(rtson)
library(purrr)
library(dplyr)

AbstractOperatorContext <- R6Class(
  "AbstractOperatorContext", 
  public = list(
    
    select = function(names=list(), offset=0, nr=-1) {
      cnames = as.list(names)
      
      names(cnames) = NULL
      
      qtSchema = self$schema
      
      if (length(cnames) == 0){
        where = sapply(qtSchema$columns, function(c) (c$type != 'uint64' && c$type != 'int64') )
        cnames = lapply(qtSchema$columns[where], function(c) c$name)
      }
      
      nRows  = nr
      
      if (nRows < 0){
        nRows = qtSchema$nRows - offset
      }
      
      table = self$client$tableSchemaService$select(qtSchema$id, cnames, offset, nRows)
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
    }
  ),
  active = list(
    
    schema = function(value) {
      if (!missing(value)) stop('read only')
      return ( self$client$tableSchemaService$findByQueryHash(keys=list(self$query$qtHash))[[1]])
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
    }
  )
)

OperatorContextDev <- R6Class(
  "OperatorContextDev", 
  inherit = AbstractOperatorContext,
  public = list(
    client = NULL, 
    workflowId = NULL,
    stepId = NULL,
    initialize = function( workflowId=getOption("tercen.workflowId"),
                           stepId=getOption("tercen.stepId")) {
      
      self$client = TercenClient$new()
      self$workflowId = workflowId
      self$stepId = stepId
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
      fileDoc$metadata$contentEncoding = 'iso-8859-1'
      
      fileDoc = self$client$fileService$upload(fileDoc, bytes)
      
      task = ComputationTask$new()
      task$projectId = workflow$projectId
      task$query = self$query
      task$fileResultId = fileDoc$id
      
      task = self$client$taskService$create(task)
      
      task = self$client$taskService$waitDone(task$id)
      
      if (inherits(task$state, 'FailedState')){
        stop(task$state$reason)
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
      return (self$client$workflowService$getCubeQuery(self$workflowId, self$stepId))
    } 
  )
)

OperatorContext <- R6Class(
  "OperatorContext", 
  inherit = AbstractOperatorContext,
  public = list(
    client = NULL,
    task = NULL,
    initialize = function() { 
      self$client = TercenClient$new()
      self$task = self$client$taskService$get(parseCommandArgs()$taskId)
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
      return (self$task$query)
    } 
  )
)


#' @export
tercenCtx <- function(workflowId=getOption("tercen.workflowId"),stepId=getOption("tercen.stepId")){
  taskId = parseCommandArgs()$taskId
  if (is.null(taskId)){
    return (OperatorContextDev$new(workflowId=workflowId, stepId=stepId))
  } else {
    return (OperatorContext$new())
  }
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