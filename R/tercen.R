library(R6)
library(teRcenHttp)
library(rtson)
library(dplyr)
library(tibble)

unbox <- function(object) {
  return (rtson::tson.scalar(object))
}

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
}

#' Tercen Client for R
#' 
#' Access Tercen at \url{http://tercen.com} 
#'  
#' @name tercen-package
#' @aliases tercen
#' @docType package
#' @import R6 teRcenHttp rtson dplyr tibble
NULL

#' @export
TercenClient <- R6Class("TercenClient", inherit = ServiceFactory, public = list(session = NULL, 
    initialize = function(username = getOption("tercen.username"), password = getOption("tercen.password"), 
        authToken = NULL, serviceUri = getOption("tercen.serviceUri", default = "https://tercen.com/api/v1/")) {
        argsMap = parseCommandArgs()
        if (!is.null(argsMap$serviceUri)) {
            super$initialize(argsMap$serviceUri)
        } else {
            super$initialize(serviceUri)
        }
        token = argsMap$token
        if (is.null(token)) {
            token = authToken
        }
        if (is.null(token)) {
            if (is.null(username) || is.null(password)) stop("token or username and password are required")
            self$session = self$userService$connect(username, password)
            self$userService$client$token = self$session$token$token
        } else {
            self$userService$client$token = token
        }
    }))

Base <- R6::R6Class("Base", portable = TRUE, public = list(subKind = NULL, initialize = function(json = NULL) {
    if (!is.null(json)) {
        self$initJson(json)
    } else {
        self$init()
    }
}, init = function() {
}, initJson = function(json) {
    self$subKind = json$subKind
}, toTson = function() {
    return(list())
}))

MultiPart <- R6::R6Class("MultiPart", 
                         public = list(headers = list(), 
                                       content = NULL,
                                       initialize = function(headers, content = NULL) {
                                         if (is.null(content) && is.null(string)) stop("MultiPart : content is required")
                                         if (is.null(headers)) stop("MultiPart : headers is required")
                                         self$headers = headers
                                         self$content = content
                                       },
                                       toTson = function(){
                                         list(headers=self$headers, content=self$content)
                                       }))

# MultiPartMixTransformer <- R6::R6Class("MultiPartMixTransformer", public = list( 
#     initialize = function() {
#         if (is.null(frontier)) stop("MultiPartMixTransformer : frontier is required")
#         self$frontier = frontier
#     }, encode = function(parts) {
#         con = rawConnection(raw(0), "r+")
#         
#         lapply(parts, function(part) {
#             writeChar("--", con, eos = NULL)
#             writeChar(self$frontier, con, eos = NULL)
#             writeBin(as.integer(13), con, size = 1, endian = "little")
#             writeBin(as.integer(10), con, size = 1, endian = "little")
#             
#             headers = part$headers
#             
#             lapply(names(headers), function(name) {
#                 writeChar(name, con, eos = NULL)
#                 writeChar(": ", con, eos = NULL)
#                 writeChar(headers[[name]], con, eos = NULL)
#                 writeBin(as.integer(13), con, size = 1, endian = "little")
#                 writeBin(as.integer(10), con, size = 1, endian = "little")
#             })
#             
#             writeBin(as.integer(13), con, size = 1, endian = "little")
#             writeBin(as.integer(10), con, size = 1, endian = "little")
#             
#             if (!is.null(part$bytes)) {
#                 writeBin(part$bytes, con, size = 1, endian = "little")
#             } else {
#                 writeChar(part$string, con, eos = NULL)
#             }
#             
#             
#             writeBin(as.integer(13), con, size = 1, endian = "little")
#             writeBin(as.integer(10), con, size = 1, endian = "little")
#         })
#         
#         writeChar("--", con, eos = NULL)
#         writeChar(self$frontier, con, eos = NULL)
#         writeChar("--", con, eos = NULL)
#         writeBin(as.integer(13), con, size = 1, endian = "little")
#         writeBin(as.integer(10), con, size = 1, endian = "little")
#         
#         bytes = rawConnectionValue(con)
#         
#         close(con)
#         
#         return(bytes)
#     }))

HttpClient <- R6::R6Class("HttpClient", public = list(initialize = function() {
    
}, getHeaders = function(headers) {
    headers[["Expect"]] = ""
    return(headers)
}, get = function(url, 
                  headers = structure(list(), names=character(0)),
                  query = structure(list(), names=character(0))) {
    return(GET(url, 
               headers=self$getHeaders(headers),
               query = query,
               response_type="application/tson"))
}, post = function(url,
                   headers = structure(list(), names=character(0)),
                   query = structure(list(), names=character(0)),
                   body = NULL,
                   content_type="application/tson",
                   response_type="application/tson") {
    return(POST(url, 
                headers = self$getHeaders(headers),
                query = query,
                body = body, 
                content_type = content_type,
                response_type=response_type))
},multipart = function(url,
                  headers = structure(list(), names=character(0)),
                  query = structure(list(), names=character(0)),
                  body = NULL,
                  response_type="application/tson") {
  return(MULTIPART(url, 
              headers = self$getHeaders(headers),
              query = query,
              body = body, 
              response_type=response_type))
}, put = function(url,
                   headers = structure(list(), names=character(0)),
                   query = structure(list(), names=character(0)),
                   body = NULL,
                   content_type="application/tson",
                   response_type="application/tson") {
  return(PUT(url, 
              headers = self$getHeaders(headers),
              query = query,
              body = body, 
              content_type = content_type,
              response_type=response_type))
}, delete = function(url,
                  headers = structure(list(), names=character(0)),
                  query = structure(list(), names=character(0)),
                  body = NULL,
                  content_type="application/tson",
                  response_type="application/tson") {
  return(DELETE(url, 
             headers = self$getHeaders(headers),
             query = query,
             body = body, 
             content_type = content_type,
             response_type="application/tson"))
}
))

AuthHttpClient <- R6::R6Class("AuthHttpClient", inherit = HttpClient, public = list(token = NULL, 
    initialize = function(token = NULL) {
        self$token = token
        super$initialize()
    }, getHeaders = function(headers) {
        if (!is.null(self$token)) headers[["authorization"]] = self$token
        headers[["Expect"]] = ""
        return(headers)
    }))

HttpClientService <- R6::R6Class("HttpClientService", public = list(client = NULL, 
    baseRestUri = NULL, uri = NULL, initialize = function(baseRestUri, client) {
        if (endsWith(baseRestUri, "/")) {
            self$baseRestUri = baseRestUri
        } else {
            self$baseRestUri = paste0(baseRestUri, "/")
        }
        self$client = client
    }, onResponseError = function(response, msg = "") {
        body = response$content
        stop(paste0("Failed : ", msg, " : status=", response$status, " body=", 
                    toString(body)))
        
    }, toTson = function(object) {
        return(object$toTson())
    }, fromTson = function(object) {
        return(createObjectFromJson(object))
    }, getServiceUri = function(uri, ...) {
        return(paste0(self$baseRestUri, uri, ...))
    }, create = function(object) {
        url = self$getServiceUri(self$uri)
        body = self$toTson(object)
        response = self$client$put(url, body = body)
        if (response$status != 200) {
            self$onResponseError(response, "create")
        }
        return(response$content)
    }, get = function(id, useFactory = TRUE) {
        url = self$getServiceUri(self$uri)
        response = self$client$get(url, query = list(id = id, useFactory = tolower(toString(useFactory))))
        if (response$status != 200) {
            self$onResponseError(response, "get")
        }
        return(response$content)
    }, delete = function(id, rev) {
        url = self$getServiceUri(self$uri)
        response = self$client$delete(url, query = list(id = id, rev = rev))
        if (response$status != 200) {
            self$onResponseError(response, "delete")
        }
    }, update = function(object) {
        url = self$getServiceUri(self$uri)
        body = self$toTson(object)
        response = self$client$post(url, body = body)
        if (response$status != 200) {
            self$onResponseError(response, "update")
        }
        object$rev = response$content[[1]]
        return(object$rev)
    }, list = function(ids, useFactory = TRUE) {
        url = self$getServiceUri(self$uri, "/list")
        body = body = lapply(ids, rtson::tson.scalar)
        response = self$client$post(url, body = body, 
            query = list(useFactory = tolower(toString(useFactory))))
        if (response$status != 200) {
            self$onResponseError(response, "list")
        }
        list = response$content
        objects = lapply(list, function(each) self$fromTson(each))
        return(objects)
    }, findStartKeys = function(viewName, startKey = NULL, endKey = NULL, limit = 20, 
        skip = 0, descending = TRUE, useFactory = FALSE) {
        url = self$getServiceUri(self$uri, "/", viewName)
        if (is.list(startKey)) {
            startKey = lapply(startKey, unbox)
        } else {
            startKey = unbox(startKey)
        }
        
        if (is.list(endKey)) {
            endKey = lapply(endKey, unbox)
        } else {
            endKey = unbox(endKey)
        }
        
        body = list(startKey = startKey, endKey = endKey, limit = rtson::tson.int(limit), 
            skip = rtson::tson.int(skip), descending = unbox(descending))
        response = self$client$post(url, body = body , 
            query = list(useFactory = tolower(toString(useFactory))))
        if (response$status != 200) {
            self$onResponseError(response, "findStartKeys")
        }
        list = response$content
        objects = lapply(list, function(each) self$fromTson(each))
        return(objects)
    }, findKeys = function(viewName, keys = NULL, useFactory = FALSE) {
        url = self$getServiceUri(self$uri, "/", viewName)
        body = lapply(keys, unbox)
        response = self$client$post(url, body = body,  
            query = list(useFactory = tolower(toString(useFactory))))
        if (response$status  != 200) {
            self$onResponseError(response, "findKeys")
        }
        list = response$content
        objects = lapply(list, function(each) self$fromTson(each))
        return(objects)
    }))


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
        column$values = values
        return(column)
    })
    return(table)
}
