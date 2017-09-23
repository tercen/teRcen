#' CpuTimeProfile
#'
#' @export
#' @format \code{\link{R6Class}} object, super class \code{\link{Profile}}.
#' @field name of type String inherited from super class \code{\link{Profile}}.
#' @field cpuTime of type double.
CpuTimeProfile <- R6::R6Class("CpuTimeProfile", inherit = Profile, public = list(cpuTime = NULL, 
    initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$cpuTime = 0
    }, initJson = function(json) {
        super$initJson(json)
        self$cpuTime = as.double(json$cpuTime)
    }, toTson = function() {
        m = super$toTson()
        m$kind = rtson::tson.scalar("CpuTimeProfile")
        m$cpuTime = rtson::tson.scalar(self$cpuTime)
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
