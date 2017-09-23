#' ResourceSummary
#'
#' @export
#' @format \code{\link{R6Class}} object.
#' @field storage of type int.
#' @field usedStorage of type int.
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
        self$storage = json$storage
        self$usedStorage = json$usedStorage
        self$cpuTime = as.double(json$cpuTime)
        self$usedCpuTime = as.double(json$usedCpuTime)
    }, toTson = function() {
        m = super$toTson()
        m$kind = rtson::tson.scalar("ResourceSummary")
        m$storage = rtson::tson.int(self$storage)
        m$usedStorage = rtson::tson.int(self$usedStorage)
        m$cpuTime = rtson::tson.scalar(self$cpuTime)
        m$usedCpuTime = rtson::tson.scalar(self$usedCpuTime)
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
