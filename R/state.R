#' State
#'
#' @export
#' @format \code{\link{R6Class}} object, sub classes \code{\link{RunningState}}, \code{\link{FailedState}}, \code{\link{CanceledState}}, \code{\link{DoneState}}, \code{\link{InitState}}.
State <- R6::R6Class("State", inherit = Base, public = list(initialize = function(json = NULL) {
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
    m$kind = rtson::tson.scalar("State")
    return(m)
}, print = function(...) {
    cat(yaml::as.yaml(self$toTson()))
    invisible(self)
}))
