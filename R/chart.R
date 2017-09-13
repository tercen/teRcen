#' Chart
#'
#' @export
#' @format \code{\link{R6Class}} object, sub classes \code{\link{ChartLine}}, \code{\link{ChartPoint}}, \code{\link{ChartHeatmap}}, \code{\link{ChartSize}}, \code{\link{ChartBar}}.
Chart <- R6::R6Class("Chart", inherit = Base, public = list(initialize = function(json = NULL) {
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
    m$kind = rtson::tson.scalar("Chart")
    return(m)
}, print = function(...) {
    cat(yaml::as.yaml(self$toTson()))
    invisible(self)
}))
