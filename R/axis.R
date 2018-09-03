#' Axis
#'
#' @export
#' @format \code{\link{R6Class}} object.
#' @field axisExtent object of class \code{\link{Point}}.
#' @field axisSettings object of class \code{\link{AxisSettings}}.
#' @field graphicalFactor object of class \code{\link{GraphicalFactor}}.
Axis <- R6::R6Class("Axis", inherit = Base, public = list(axisExtent = NULL, axisSettings = NULL, 
    graphicalFactor = NULL, initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$axisExtent = Point$new()
        self$axisSettings = AxisSettings$new()
        self$graphicalFactor = GraphicalFactor$new()
    }, initJson = function(json) {
        super$initJson(json)
        self$axisExtent = createObjectFromJson(json$axisExtent)
        self$axisSettings = createObjectFromJson(json$axisSettings)
        self$graphicalFactor = createObjectFromJson(json$graphicalFactor)
    }, toTson = function() {
        m = super$toTson()
        m$kind = rtson::tson.scalar("Axis")
        if (!is.null(self$axisExtent)) m$axisExtent = self$axisExtent$toTson()
        if (!is.null(self$axisSettings)) m$axisSettings = self$axisSettings$toTson()
        if (!is.null(self$graphicalFactor)) m$graphicalFactor = self$graphicalFactor$toTson()
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
