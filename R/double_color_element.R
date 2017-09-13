#' DoubleColorElement
#'
#' @export
#' @format \code{\link{R6Class}} object, super class \code{\link{ColorElement}}.
#' @field color of type int inherited from super class \code{\link{ColorElement}}.
#' @field doubleValue of type double.
DoubleColorElement <- R6::R6Class("DoubleColorElement", inherit = ColorElement, public = list(doubleValue = NULL, 
    initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$doubleValue = 0
    }, initJson = function(json) {
        super$initJson(json)
        self$doubleValue = as.double(json$doubleValue)
    }, toTson = function() {
        m = super$toTson()
        m$kind = rtson::tson.scalar("DoubleColorElement")
        m$doubleValue = rtson::tson.scalar(self$doubleValue)
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
