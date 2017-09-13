#' ChartSize
#'
#' @export
#' @format \code{\link{R6Class}} object, super class \code{\link{Chart}}, sub classes \code{\link{ChartLine}}, \code{\link{ChartPoint}}.
#' @field pointSize of type int.
ChartSize <- R6::R6Class("ChartSize", inherit = Chart, public = list(pointSize = NULL, 
    initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$pointSize = 0
    }, initJson = function(json) {
        super$initJson(json)
        self$pointSize = json$pointSize
    }, toTson = function() {
        m = super$toTson()
        m$kind = rtson::tson.scalar("ChartSize")
        m$pointSize = rtson::tson.int(self$pointSize)
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
