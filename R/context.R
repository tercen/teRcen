library(R6)
library(teRcenHttp)
library(tercenApi)
library(mtercen)
library(dplyr)
library(uuid)

# library(openssl)
 
#' @export
tercenCtx <- function(workflowId=getOption("tercen.workflowId"),
                      stepId=getOption("tercen.stepId"), 
                      taskId = NULL,
                      authToken = NULL, 
                      username = getOption("tercen.username"), password = getOption("tercen.password"),
                      serviceUri = getOption("tercen.serviceUri", default = "https://tercen.com/service")){
  
  
  
  if (is.null(workflowId)){
    if (is.null(taskId) && is.null(parseCommandArgs()$taskId)) {
      stop("Failed to build tercen context, workflowId and stepId are required")
    } 
    return (OperatorContext$new(taskId=taskId,
                                authToken=authToken, 
                                username=username, 
                                password=password, 
                                serviceUri=serviceUri))
  } else {
    if (is.null(stepId)) stop("Failed to build tercen context, stepId is required")
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
  return (ctx$cselect(argNames(...)))
}

#' @export
rselect <- function(ctx, ...){
  return (ctx$rselect(argNames(...)))
}

#' @export
select.AbstractOperatorContext <- function(ctx, ...){
  return (ctx$select(argNames(...)))
}

#' @export
as.matrix.AbstractOperatorContext <- function(ctx, ...){
  return (ctx$as.matrix(...))
}

argNames = function(...){
  nn = as.list(substitute(list(...)))[-1L]
  return (lapply(nn, toString))
}

#' @export
remove.prefix = function(fname){
  parts = strsplit(fname, "[.]")[[1]]
  if (length(parts) > 1){
    return (paste(as.list(parts[-1]), collapse = '.'))
  } else {
    return (fname)
  }
}