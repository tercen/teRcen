#' Worker
#'
#' @export
#' @format \code{\link{R6Class}} object.
#' @field status of type String.
#' @field name of type String.
#' @field uri of type String.
#' @field priority of type double.
#' @field nCPU of type int.
#' @field nThread of type int.
#' @field memory of type double.
#' @field nAvailableThread of type int.
#' @field availableMemory of type double.
#' @field availableTaskTypes list of type String.
#' @field lastDateActivity of type String.
#' @field heartBeat of type int.
Worker <- R6::R6Class("Worker", inherit = Base, public = list(status = NULL, name = NULL, 
    uri = NULL, priority = NULL, nCPU = NULL, nThread = NULL, memory = NULL, nAvailableThread = NULL, 
    availableMemory = NULL, availableTaskTypes = NULL, lastDateActivity = NULL, heartBeat = NULL, 
    initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$status = ""
        self$name = ""
        self$uri = ""
        self$priority = 0
        self$nCPU = 0
        self$nThread = 0
        self$memory = 0
        self$nAvailableThread = 0
        self$availableMemory = 0
        self$availableTaskTypes = list()
        self$lastDateActivity = ""
        self$heartBeat = 0
    }, initJson = function(json) {
        super$initJson(json)
        self$status = json$status
        self$name = json$name
        self$uri = json$uri
        self$priority = as.double(json$priority)
        self$nCPU = json$nCPU
        self$nThread = json$nThread
        self$memory = as.double(json$memory)
        self$nAvailableThread = json$nAvailableThread
        self$availableMemory = as.double(json$availableMemory)
        self$availableTaskTypes = json$availableTaskTypes
        self$lastDateActivity = json$lastDateActivity
        self$heartBeat = json$heartBeat
    }, toTson = function() {
        m = super$toTson()
        m$kind = tson.scalar("Worker")
        m$status = tson.scalar(self$status)
        m$name = tson.scalar(self$name)
        m$uri = tson.scalar(self$uri)
        m$priority = tson.scalar(self$priority)
        m$nCPU = tson.int(self$nCPU)
        m$nThread = tson.int(self$nThread)
        m$memory = tson.scalar(self$memory)
        m$nAvailableThread = tson.int(self$nAvailableThread)
        m$availableMemory = tson.scalar(self$availableMemory)
        m$availableTaskTypes = lapply(self$availableTaskTypes, function(each) tson.scalar(each))
        m$lastDateActivity = tson.scalar(self$lastDateActivity)
        m$heartBeat = tson.int(self$heartBeat)
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
