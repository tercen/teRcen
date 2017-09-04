#' DoneState
#'
#' @export
#' @format \code{\link{R6Class}} object, super class \code{\link{State}}.
DoneState <- R6::R6Class("DoneState", inherit = State, public = list(initialize = function(json = NULL) {
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
    m$kind = rtson::tson.scalar(jsonlite::unbox("DoneState"))
    return(m)
}, print = function(...) {
    cat(yaml::as.yaml(self$toTson()))
    invisible(self)
}))
