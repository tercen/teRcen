library(R6)
library(httr)
library(jsonlite)
library(rtson)
library(dplyr)
library(tibble)

.onLoad <- function(libname, pkgname) {
    
    # Unlock the class
    TableSchemaService$unlock()
    
    TableSchemaService$set("public", "select", function(tableId, cnames, offset, 
        limit) {
        bytes = self$selectStream(tableId, cnames, offset, limit)
        table = createObjectFromJson(rtson::fromTSON(bytes))
        return(table)
    }, overwrite = TRUE)
    
    # Lock the class again
    TableSchemaService$lock()
}

#' Tercen Client for R
#' 
#' Access Tercen at \url{http://tercen.com} 
#'  
#' @name tercen-package
#' @aliases tercen
#' @docType package
#' @import R6 httr rtson jsonlite dplyr tibble
NULL

#' @export
TercenClient <- R6Class("TercenClient", inherit = ServiceFactory, public = list(session = NULL, 
    initialize = function(username = getOption("tercen.username"), password = getOption("tercen.password"), 
        authToken = NULL, serviceUri = getOption("tercen.serviceUri", default = "https://tercen.com/service")) {
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

MultiPart <- R6::R6Class("MultiPart", public = list(headers = list(), string = NULL, 
    bytes = NULL, initialize = function(headers, bytes = NULL, string = NULL) {
        if (is.null(bytes) && is.null(string)) stop("MultiPart : bytes or string is required")
        if (is.null(headers)) stop("MultiPart : headers is required")
        self$headers = headers
        self$bytes = bytes
        self$string = string
    }))

MultiPartMixTransformer <- R6::R6Class("MultiPartMixTransformer", public = list(frontier = "", 
    initialize = function(frontier) {
        if (is.null(frontier)) stop("MultiPartMixTransformer : frontier is required")
        self$frontier = frontier
    }, encode = function(parts) {
        con = rawConnection(raw(0), "r+")
        
        lapply(parts, function(part) {
            writeChar("--", con, eos = NULL)
            writeChar(self$frontier, con, eos = NULL)
            writeBin(as.integer(13), con, size = 1, endian = "little")
            writeBin(as.integer(10), con, size = 1, endian = "little")
            
            headers = part$headers
            
            lapply(names(headers), function(name) {
                writeChar(name, con, eos = NULL)
                writeChar(": ", con, eos = NULL)
                writeChar(headers[[name]], con, eos = NULL)
                writeBin(as.integer(13), con, size = 1, endian = "little")
                writeBin(as.integer(10), con, size = 1, endian = "little")
            })
            
            writeBin(as.integer(13), con, size = 1, endian = "little")
            writeBin(as.integer(10), con, size = 1, endian = "little")
            
            if (!is.null(part$bytes)) {
                writeBin(part$bytes, con, size = 1, endian = "little")
            } else {
                writeChar(part$string, con, eos = NULL)
            }
            
            
            writeBin(as.integer(13), con, size = 1, endian = "little")
            writeBin(as.integer(10), con, size = 1, endian = "little")
        })
        
        writeChar("--", con, eos = NULL)
        writeChar(self$frontier, con, eos = NULL)
        writeChar("--", con, eos = NULL)
        writeBin(as.integer(13), con, size = 1, endian = "little")
        writeBin(as.integer(10), con, size = 1, endian = "little")
        
        bytes = rawConnectionValue(con)
        
        close(con)
        
        return(bytes)
    }))

HttpClient <- R6::R6Class("HttpClient", public = list(initialize = function() {
    
}, getHeaders = function(headers) {
    headers[["Expect"]] = ""
    return(headers)
}, get = function(url, headers = c(), query = list()) {
    return(GET(url, add_headers(.headers = self$getHeaders(headers)), query = query))
}, post = function(url, body = NULL, headers = c(), encode = "json", query = list()) {
    return(POST(url, add_headers(.headers = self$getHeaders(headers)), body = body, 
        encode = encode, query = query))
}, put = function(url, body = NULL, headers = c(), encode = "json", query = list()) {
    return(PUT(url, add_headers(.headers = self$getHeaders(headers)), body = body, 
        encode = encode, query = query))
}, delete = function(url, body = NULL, headers = c(), encode = "json", query = list()) {
    return(DELETE(url, add_headers(.headers = self$getHeaders(headers)), body = body, 
        encode = encode, query = query))
}))

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
        body = rtson::fromTSON(content(response))
        if (is.list(body)) {
            stop(jsonlite::toJSON(body, auto_unbox = TRUE))
        } else {
            stop(paste0("Failed : ", msg, " : status=", status_code(response), " body=", 
                toString(body)))
        }
        
    }, toTson = function(object) {
        return(object$toTson())
    }, fromTson = function(object) {
        return(createObjectFromJson(object))
    }, getServiceUri = function(uri, ...) {
        return(httr::parse_url(paste0(self$baseRestUri, uri, ...)))
    }, create = function(object) {
        url = self$getServiceUri(self$uri)
        body = self$toTson(object)
        response = self$client$put(url, body = rtson::toTSON(body), encode = "raw")
        if (status_code(response) != 200) {
            self$onResponseError(response, "create")
        }
        object = self$fromTson(rtson::fromTSON(content(response)))
        return(object)
    }, get = function(id, useFactory = TRUE) {
        url = self$getServiceUri(self$uri)
        response = self$client$get(url, query = list(id = id, useFactory = tolower(toString(useFactory))))
        if (status_code(response) != 200) {
            self$onResponseError(response, "get")
        }
         
        object = self$fromTson(rtson::fromTSON(content(response)))
        return(object)
    }, delete = function(id, rev) {
        url = self$getServiceUri(self$uri)
        response = self$client$delete(url, query = list(id = id, rev = rev))
        if (status_code(response) != 200) {
            self$onResponseError(response, "delete")
        }
    }, update = function(object) {
        url = self$getServiceUri(self$uri)
        body = self$toTson(object)
        response = self$client$post(url, body = rtson::toTSON(body), encode = "raw")
        if (status_code(response) != 200) {
            self$onResponseError(response, "update")
        }
        object$rev = rtson::fromTSON(content(response))[[1]]
        return(object$rev)
    }, list = function(ids, useFactory = TRUE) {
        url = self$getServiceUri(self$uri, "/list")
        body = body = lapply(ids, jsonlite::unbox)
        response = self$client$post(url, body = rtson::toTSON(body), encode = "raw", 
            query = list(useFactory = tolower(toString(useFactory))))
        if (status_code(response) != 200) {
            self$onResponseError(response, "list")
        }
        list = rtson::fromTSON(content(response))
        objects = lapply(list, function(each) self$fromTson(each))
        return(objects)
    }, findStartKeys = function(viewName, startKey = NULL, endKey = NULL, limit = 20, 
        skip = 0, descending = TRUE, useFactory = FALSE) {
        url = self$getServiceUri(self$uri, "/", viewName)
        if (is.list(startKey)) {
            startKey = lapply(startKey, jsonlite::unbox)
        } else {
            startKey = jsonlite::unbox(limit)
        }
        
        if (is.list(endKey)) {
            endKey = lapply(endKey, jsonlite::unbox)
        } else {
            endKey = jsonlite::unbox(limit)
        }
        
        body = list(startKey = startKey, endKey = endKey, limit = jsonlite::unbox(limit), 
            skip = jsonlite::unbox(skip), descending = jsonlite::unbox(descending))
        response = self$client$post(url, body = rtson::toTSON(body), encode = "raw", 
            query = list(useFactory = tolower(toString(useFactory))))
        if (status_code(response) != 200) {
            self$onResponseError(response, "findStartKeys")
        }
        list = rtson::fromTSON(content(response))
        objects = lapply(list, function(each) self$fromTson(each))
        return(objects)
    }, findKeys = function(viewName, keys = NULL, useFactory = FALSE) {
        url = self$getServiceUri(self$uri, "/", viewName)
        body = lapply(keys, jsonlite::unbox)
        # rtson::tson.scalar(keys)
        response = self$client$post(url, body = rtson::toTSON(body), encode = "raw", 
            query = list(useFactory = tolower(toString(useFactory))))
        if (status_code(response) != 200) {
            self$onResponseError(response, "findKeys")
        }
        list = rtson::fromTSON(content(response))
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
        } else if (argv == "--slaveUri") {
            index = index + 1
            if (index > length(args)) 
                showUsage()
            list[["slaveUri"]] = args[[index]]
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
    names(l) = lapply(table$columns, function(column) column$name)
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
