library(R6)
library(tercenApi)
library(teRcenHttp)
  
#' @export
HttpClient <- R6::R6Class("HttpClient", public = list(initialize = function() {
  
}, getHeaders = function(headers) {
  headers[["Expect"]] = ""
  return(headers)
}, get = function(url, headers = structure(list(), names = character(0)), response_type = "default", 
                  query = structure(list(), names = character(0))) {
  return(GET(url, headers = self$getHeaders(headers), query = query, response_type = response_type))
}, post = function(url, headers = structure(list(), names = character(0)), query = structure(list(), 
     names = character(0)), body = NULL, content_type = "application/tson", response_type = "application/tson") {
  return(POST(url, headers = self$getHeaders(headers), query = query, body = body, 
              content_type = content_type, response_type = response_type))
}, multipart = function(url, headers = structure(list(), names = character(0)), query = structure(list(), 
                                                                                                  names = character(0)), body = NULL, response_type = "application/tson") {
  return(MULTIPART(url, headers = self$getHeaders(headers), query = query, body = body, 
                   response_type = response_type))
}, put = function(url, headers = structure(list(), names = character(0)), query = structure(list(), 
                                                                                            names = character(0)), body = NULL, content_type = "application/tson", response_type = "application/tson") {
  return(PUT(url, headers = self$getHeaders(headers), query = query, body = body, 
             content_type = content_type, response_type = response_type))
}, delete = function(url, headers = structure(list(), names = character(0)), query = structure(list(), 
                                                                                               names = character(0)), body = NULL, content_type = "application/tson", response_type = "default") {
  return(DELETE(url, headers = self$getHeaders(headers), query = query, body = body, 
                content_type = content_type, response_type = response_type))
}))

#' @export
AuthHttpClient <- R6::R6Class("AuthHttpClient", inherit = HttpClient, 
                              public = list(token = NULL, 
                              initialize = function(token = NULL) {
                                self$token = token
                                super$initialize()
                              }, getHeaders = function(headers) {
                                if (!is.null(self$token)) headers[["authorization"]] = self$token
                                headers[["Expect"]] = ""
                                return(headers)
                              }))