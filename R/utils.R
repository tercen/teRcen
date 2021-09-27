library(R6)
library(tercenApi)
library(teRcenHttp)
library(dplyr)
library(tibble)
 

unbox <- function(object) {
  return(tson.scalar(object))
}

showUsage = function(){
  print("Usage : ....")
}

#' parseCommandArgs
#' 
#' @export 
parseCommandArgs <- function() {
  args = commandArgs(trailingOnly = TRUE)
  index = 1
  list = list()
  while (index <= length(args)) {
    argv = args[[index]]
    if (argv == "--token") {
      index = index + 1
      if (index > length(args)) 
        showUsage()
      list[["token"]] = args[[index]]
    } else if (argv == "--taskId") {
      index = index + 1
      if (index > length(args)) 
        showUsage()
      list[["taskId"]] = args[[index]]
    } else if (argv == "--serviceUri") {
      index = index + 1
      if (index > length(args)) 
        showUsage()
      list[["serviceUri"]] = args[[index]]
    } else if (argv == "--username") {
      index = index + 1
      if (index > length(args)) 
        showUsage()
      list[["username"]] = args[[index]]
    } else if (argv == "--password") {
      index = index + 1
      if (index > length(args)) 
        showUsage()
      list[["password"]] = args[[index]]
    }
    index = index + 1
  }
  return(list)
}

#' @export
as_tibble.Table <- function(table, ...) {
  l = lapply(table$columns, function(column) column$values)
  names(l) = lapply(table$columns, function(column) {
    if (nchar(column$name) == 0) {
      return(".all")
    }
    return(column$name)
  })
  return(as_tibble(l))
}

#' @export
dataframe.as.table = function(df) {
  table = Table$new()
  table$nRows = as.integer(dim(df)[[1]])
  table$columns = lapply(colnames(df), function(cname) {
    column = Column$new()
    column$name = cname
    values = df[[cname]]
    if (is.factor(values)) 
      values = as.character(values)
    
    if (is.character(values)) {
      column$type = "string"
    } else if (is.double(values)) {
      column$type = "double"
    } else if (is.integer(values)) {
      column$type = "int32"
    } else {
      stop("bad column type")
    }
    
    column$values = values
    return(column)
  })
  return(table)
}
