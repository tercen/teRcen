#' State
#'
#' @export
#' @format \code{\link{R6Class}} object, sub classes \code{\link{RunningState}}, \code{\link{FailedState}}, \code{\link{CanceledState}}, \code{\link{RunningDependentState}}, \code{\link{DoneState}}, \code{\link{InitState}}, \code{\link{PendingState}}.
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
    m$kind = tson.scalar("State")
    return(m)
}, print = function(...) {
    cat(yaml::as.yaml(self$toTson()))
    invisible(self)
}))
