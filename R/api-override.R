library(R6)
library(tercenApi)
library(teRcenHttp)
library(mtercen)
library(dplyr)
library(tibble)

.onLoad <- function(libname, pkgname) {
  
  # Unlock the class
  TableSchemaService$unlock()
  
  TableSchemaService$set("public", "select", function(tableId, cnames = list(), 
                                                      offset = 0, limit = -1) {
    object = self$selectStream(tableId, cnames, offset, limit)
    table = createObjectFromJson(object)
    return(table)
  }, overwrite = TRUE)
  
  TableSchemaService$set("public", "selectSchema", function(schema = NULL, names = list(), 
                                                            offset = 0, nr = -1) {
    cnames = as.list(names)
    names(cnames) = NULL
    
    if (length(cnames) == 0) {
      where = sapply(schema$columns, function(c) (c$type != "uint64" && c$type != 
                                                    "int64"))
      cnames = lapply(schema$columns[where], function(c) c$name)
    }
    
    return(as_tibble(self$select(schema$id, cnames, offset, nr)))
  }, overwrite = TRUE)
  
  
  
  # Lock the class again
  TableSchemaService$lock()
  
  # Unlock the class
  Table$unlock()
  
  Table$set("public", "print", function(...) {
    print(as_tibble(self))
    invisible(self)
  }, overwrite = TRUE)
  
  # Lock the class again
  Table$lock()
  
  # Unlock the class
  Relation$unlock()
  
  Relation$set("active", "rids", function(value) {
    if (!missing(value)) stop('read only')
    return (paste0(self$id, "._rids"))
  }, overwrite = TRUE)
  
  # Lock the class again
  Relation$lock()
}