#' JoinOperator
#'
#' @export
#' @format \code{\link{R6Class}} object, sub classes \code{\link{JoinOperator1}}.
JoinOperator <- R6::R6Class("JoinOperator", inherit = Base, public = list(initialize = function(json = NULL) {
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
    m$kind = rtson::tson.scalar("JoinOperator")
    return(m)
}, print = function(...) {
    cat(yaml::as.yaml(self$toTson()))
    invisible(self)
}))
