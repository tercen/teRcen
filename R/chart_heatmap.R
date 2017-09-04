#' ChartHeatmap
#'
#' @export
#' @format \code{\link{R6Class}} object, super class \code{\link{Chart}}.
ChartHeatmap <- R6::R6Class("ChartHeatmap", inherit = Chart, public = list(initialize = function(json = NULL) {
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
    m$kind = rtson::tson.scalar(jsonlite::unbox("ChartHeatmap"))
    return(m)
}, print = function(...) {
    cat(yaml::as.yaml(self$toTson()))
    invisible(self)
}))
