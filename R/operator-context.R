library(R6)
library(teRcenHttp)
library(tercenApi)
library(mtercen)
library(dplyr)
# library(openssl)

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
    op.value = function(name, type=as.character, default=NULL){
      property = Find(function(propertyValue) propertyValue$name == name ,
                      self$query$operatorSettings$operatorRef$propertyValues)
      if (is.null(property)) return(default)
      return(type(property$value))
    },
    as.matrix = function(fill=0.0) {
      data = self$select(names=c(".ri", ".ci", ".y"))
      matrix(acast(data$.ri,
                   data$.ci, 
                   data$.y,
                   self$rschema$nRows,
                   self$cschema$nRows, fill), 
             nrow = self$rschema$nRows,
             ncol=self$cschema$nRows)
    },
    select = function(names=list(), offset=0, nr=-1) {
      if (self$isPairwise){
        return (self$selectSchemaPairwise(self$schema, names=names,offset=offset,nr=nr))
      } else {
        return (self$selectSchema(self$schema, names=names,offset=offset,nr=nr))
      }
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
      
      if (length(cnames) == 0){
        where = sapply(schema$columns, function(c) (c$type != 'uint64' && c$type != 'int64') )
        cnames = lapply(schema$columns[where], function(c) c$name)
      }
      
      return(as_tibble(self$client$tableSchemaService$select(schema$id, cnames, offset, nr)))
    },
    selectSchemaPairwise = function(schema=NULL, names=list(), offset=0, nr=-1) {
      cnames = as.list(names)
      names(cnames) = NULL
      
      if (length(cnames) == 0){
        where = sapply(schema$columns, function(c) (c$type != 'uint64' && c$type != 'int64') )
        cnames = lapply(schema$columns[where], function(c) c$name)
      }
      
      return(as_tibble(self$client$tableSchemaService$selectPairwise(schema$id, cnames, offset, nr)))
    },
    addNamespace = function(df){
      ns = self$namespace
      names(df) = sapply(names(df), function(x){
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
    isPairwise = function(value) {
      if (!missing(value)) stop('read only')
      intersec = intersect(self$cnames, self$rnames)
      intersec = intersec[nchar(intersec) > 0]
      return (length(intersec) > 0)
    },
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
    crelation = function(value) {
      if (!missing(value)) stop('read only')
      return ( as_relation(self$cschema) )
    },
    rrelation = function(value) {
      if (!missing(value)) stop('read only')
      return ( as_relation(self$rschema) )
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
    },
    colors = function(value) {
      if (!missing(value)) stop('read only')
      color.factors = unlist(lapply(self$query$axisQueries, function(axisQuery) axisQuery$colors))
      color.factor.names = lapply(color.factors, function(factor) factor$name)
      return(color.factor.names) 
    },
    labels = function(value) {
      if (!missing(value)) stop('read only')
      color.factors = unlist(lapply(self$query$axisQueries, function(axisQuery) axisQuery$labels))
      color.factor.names = lapply(color.factors, function(factor) factor$name)
      return(color.factor.names) 
    },
    errors = function(value) {
      if (!missing(value)) stop('read only')
      color.factors = unlist(lapply(self$query$axisQueries, function(axisQuery) axisQuery$errors))
      color.factor.names = lapply(color.factors, function(factor) factor$name)
      return(color.factor.names) 
    },
    xAxis = function(value) {
      if (!missing(value)) stop('read only')
      color.factors = lapply(self$query$axisQueries, function(axisQuery) axisQuery$xAxis)
      color.factor.names = lapply(color.factors, function(factor) factor$name)
      ll = unique(color.factor.names)
      return (ll[nchar(ll) > 0])
    },
    yAxis = function(value) {
      if (!missing(value)) stop('read only')
      color.factors = lapply(self$query$axisQueries, function(axisQuery) axisQuery$yAxis)
      color.factor.names = lapply(color.factors, function(factor) factor$name)
      ll = unique(color.factor.names)
      return (ll[nchar(ll) > 0])
    },
    hasXAxis = function(value){
      if (!missing(value)) stop('read only')
      return (!is.null(base::Find(function(each) each$name == '.x', self$schema$columns)))
    },
    hasNumericXAxis = function(value){
      if (!missing(value)) stop('read only')
      column = base::Find(function(each) each$name == '.x', self$schema$columns)
      if (is.null(column)) return(FALSE)
      if (column$type != 'double') return(FALSE)
      return(TRUE)
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
      
      if (inherits(computed.df, 'OperatorResult')){
        result = computed.df
      } else {
        result = OperatorResult$new()
        if (inherits(computed.df, 'list')){
          result$tables = lapply(computed.df, tercen::dataframe.as.table)
        } else {
          result$tables = list(tercen::dataframe.as.table(computed.df))
        }
      }
      
      # bytes = toTSON(result$toTson())
      
      bytes = result$toTson()
      
      workflow = self$workflow
      
      fileDoc = FileDocument$new()
      fileDoc$name = 'result'
      fileDoc$projectId = workflow$projectId
      fileDoc$acl$owner = workflow$acl$owner
      fileDoc$metadata$contentType = 'application/octet-stream'
      # fileDoc$metadata$md5Hash = toString(openssl::md5(bytes))
      # fileDoc$size = length(bytes)
      
      fileDoc = self$client$fileService$upload(fileDoc, bytes)
      
      # the task can be null if run from a R session
      if (is.null(self$task)){
        print('task is null, create a task')
        if (is.null(self$client$session$serverVersion)){
          task = ComputationTask$new()
          task$state = InitState$new()
          task$owner = workflow$acl$owner
          task$projectId = workflow$projectId
          task$query = self$query
          task$fileResultId = fileDoc$id
          self$task = self$client$taskService$create(task)
        } else {
          task = RunComputationTask$new()
          task$state = InitState$new()
          task$owner = workflow$acl$owner
          task$projectId = workflow$projectId
          task$query = self$query
          task$fileResultId = fileDoc$id
          self$task = self$client$taskService$create(task)
        }
        
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
                          serviceUri = getOption("tercen.serviceUri",
                                                 default = "https://tercen.com/service")) { 
      
      self$client = TercenClient$new(authToken=authToken, username=username, password=password, serviceUri=serviceUri)
      
      if (is.null(taskId)){
        self$task = self$client$taskService$get(parseCommandArgs()$taskId)
      } else {
        self$task = self$client$taskService$get(taskId)
      }
    },
    
    save = function(computed.df){
      
      if (inherits(computed.df, 'OperatorResult')){
        result = computed.df
      } else {
        result = OperatorResult$new()
        if (inherits(computed.df, 'list')){
          result$tables = lapply(computed.df, tercen::dataframe.as.table)
        } else {
          result$tables = list(tercen::dataframe.as.table(computed.df))
        }
      }
      
      # bytes = toTSON(result$toTson())
      
      bytes = result$toTson()
      
      
      if (nchar(self$task$fileResultId) == 0){
        # webapp scenario
        fileDoc = FileDocument$new()
        
        fileDoc$name = 'result'
        fileDoc$projectId = self$task$projectId
        fileDoc$acl$owner = self$task$owner
        fileDoc$metadata$contentType = 'application/octet-stream'
        # fileDoc$metadata$md5Hash = toString(openssl::md5(bytes))
        # fileDoc$size = length(bytes)
        
        
        fileDoc = self$client$fileService$upload(fileDoc, bytes)
        
        self$task$fileResultId = fileDoc$id
        rev = self$client$taskService$update(self$task)
        self$task$rev = rev
        
        self$client$taskService$runTask(self$task$id)
        
        self$task = self$client$taskService$waitDone(self$task$id)
        
        if (inherits(self$task$state, 'FailedState')){
          stop(self$task$state$reason)
        }
        
      } else {
        fileDoc = self$client$fileService$get(self$task$fileResultId)
        # fileDoc$metadata$md5Hash = toString(openssl::md5(bytes))
        # fileDoc$size = length(bytes)
        
        self$client$fileService$upload(fileDoc, bytes)
      }
    }
  ),
  active = list(
    workflow = function(value){
      if (!missing(value)) stop('read only')
      stop('not impl')
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