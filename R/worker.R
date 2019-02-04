#' Worker
#'
#' @export
#' @format \code{\link{R6Class}} object.
#' @field name of type String.
#' @field uri of type String.
#' @field threads of type int.
#' @field availableMemory of type double.
#' @field maxMemory of type double.
#' @field availableTaskTypes list of type String.
#' @field priority of type double.
Worker <- R6::R6Class("Worker", inherit = Base, public = list(name = NULL, uri = NULL, 
    threads = NULL, availableMemory = NULL, maxMemory = NULL, availableTaskTypes = NULL, 
    priority = NULL, initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$name = ""
        self$uri = ""
        self$threads = 0
        self$availableMemory = 0
        self$maxMemory = 0
        self$availableTaskTypes = list()
        self$priority = 0
    }, initJson = function(json) {
        super$initJson(json)
        self$name = json$name
        self$uri = json$uri
        self$threads = json$threads
        self$availableMemory = as.double(json$availableMemory)
        self$maxMemory = as.double(json$maxMemory)
        self$availableTaskTypes = json$availableTaskTypes
        self$priority = as.double(json$priority)
    }, toTson = function() {
        m = super$toTson()
        m$kind = rtson::tson.scalar("Worker")
        m$name = rtson::tson.scalar(self$name)
        m$uri = rtson::tson.scalar(self$uri)
        m$threads = rtson::tson.int(self$threads)
        m$availableMemory = rtson::tson.scalar(self$availableMemory)
        m$maxMemory = rtson::tson.scalar(self$maxMemory)
        m$availableTaskTypes = lapply(self$availableTaskTypes, function(each) rtson::tson.scalar(each))
        m$priority = rtson::tson.scalar(self$priority)
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
