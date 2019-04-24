#' ResourceSummary
#'
#' @export
#' @format \code{\link{R6Class}} object.
#' @field storage of type double.
#' @field usedStorage of type double.
#' @field cpuTime of type double.
#' @field usedCpuTime of type double.
ResourceSummary <- R6::R6Class("ResourceSummary", inherit = Base, public = list(storage = NULL, 
    usedStorage = NULL, cpuTime = NULL, usedCpuTime = NULL, initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$storage = 0
        self$usedStorage = 0
        self$cpuTime = 0
        self$usedCpuTime = 0
    }, initJson = function(json) {
        super$initJson(json)
        self$storage = as.double(json$storage)
        self$usedStorage = as.double(json$usedStorage)
        self$cpuTime = as.double(json$cpuTime)
        self$usedCpuTime = as.double(json$usedCpuTime)
    }, toTson = function() {
        m = super$toTson()
        m$kind = tson.scalar("ResourceSummary")
        m$storage = tson.scalar(self$storage)
        m$usedStorage = tson.scalar(self$usedStorage)
        m$cpuTime = tson.scalar(self$cpuTime)
        m$usedCpuTime = tson.scalar(self$usedCpuTime)
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
