#' Worker
#'
#' @export
#' @format \code{\link{R6Class}} object.
#' @field uri of type String.
#' @field threads of type int.
#' @field availableMemory of type int.
#' @field maxMemory of type int.
Worker <- R6::R6Class("Worker", inherit = Base, public = list(uri = NULL, threads = NULL, 
    availableMemory = NULL, maxMemory = NULL, initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$uri = ""
        self$threads = 0
        self$availableMemory = 0
        self$maxMemory = 0
    }, initJson = function(json) {
        super$initJson(json)
        self$uri = json$uri
        self$threads = json$threads
        self$availableMemory = json$availableMemory
        self$maxMemory = json$maxMemory
    }, toTson = function() {
        m = super$toTson()
        m$kind = rtson::tson.scalar("Worker")
        m$uri = rtson::tson.scalar(self$uri)
        m$threads = rtson::tson.int(self$threads)
        m$availableMemory = rtson::tson.int(self$availableMemory)
        m$maxMemory = rtson::tson.int(self$maxMemory)
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
