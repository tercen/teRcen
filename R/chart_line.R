#' ChartLine
#'
#' @export
#' @format \code{\link{R6Class}} object, super class \code{\link{ChartSize}}.
#' @field pointSize of type int inherited from super class \code{\link{ChartSize}}.
ChartLine <- R6::R6Class("ChartLine", inherit = ChartSize, public = list(initialize = function(json = NULL) {
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
    m$kind = rtson::tson.scalar("ChartLine")
    return(m)
}, print = function(...) {
    cat(yaml::as.yaml(self$toTson()))
    invisible(self)
}))
