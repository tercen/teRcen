#' RunningEnvironment
#'
#' @export
#' @format \code{\link{R6Class}} object, sub classes \code{\link{WorkerEndpointRunningEnvironment}}, \code{\link{SimpleRunningEnvironment}}.
RunningEnvironment <- R6::R6Class("RunningEnvironment", inherit = Base, public = list(initialize = function(json = NULL) {
    if (!is.null(json)) {
        self$initJson(json)
    } else {
        self$init()
    }
}, init = function() {
    super$init()
}, initJson = function(json) {
    super$initJson(json)
}, toTson = function() {
    m = super$toTson()
    m$kind = rtson::tson.scalar("RunningEnvironment")
    return(m)
}, print = function(...) {
    cat(yaml::as.yaml(self$toTson()))
    invisible(self)
}))
