#' XYAxis
#'
#' @export
#' @format \code{\link{R6Class}} object.
#' @field chart object of class \code{\link{Chart}}.
#' @field colors object of class \code{\link{Colors}}.
#' @field errors object of class \code{\link{Errors}}.
#' @field labels object of class \code{\link{Labels}}.
#' @field xAxis object of class \code{\link{Axis}}.
#' @field yAxis object of class \code{\link{Axis}}.
XYAxis <- R6::R6Class("XYAxis", inherit = Base, public = list(chart = NULL, colors = NULL, 
    errors = NULL, labels = NULL, xAxis = NULL, yAxis = NULL, initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$chart = Chart$new()
        self$colors = Colors$new()
        self$errors = Errors$new()
        self$labels = Labels$new()
        self$xAxis = Axis$new()
        self$yAxis = Axis$new()
    }, initJson = function(json) {
        super$initJson(json)
        self$chart = createObjectFromJson(json$chart)
        self$colors = createObjectFromJson(json$colors)
        self$errors = createObjectFromJson(json$errors)
        self$labels = createObjectFromJson(json$labels)
        self$xAxis = createObjectFromJson(json$xAxis)
        self$yAxis = createObjectFromJson(json$yAxis)
    }, toTson = function() {
        m = super$toTson()
        m$kind = rtson::tson.scalar("XYAxis")
        m$chart = self$chart$toTson()
        m$colors = self$colors$toTson()
        m$errors = self$errors$toTson()
        m$labels = self$labels$toTson()
        m$xAxis = self$xAxis$toTson()
        m$yAxis = self$yAxis$toTson()
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
