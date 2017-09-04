#' CubeAxisQuery
#'
#' @export
#' @format \code{\link{R6Class}} object.
#' @field pointSize of type int.
#' @field chartType of type String.
#' @field yAxis object of class \code{\link{Factor}}.
#' @field xAxis object of class \code{\link{Factor}}.
#' @field errors list of class \code{\link{Factor}}.
#' @field labels list of class \code{\link{Factor}}.
#' @field colors list of class \code{\link{Factor}}.
CubeAxisQuery <- R6::R6Class("CubeAxisQuery", inherit = Base, public = list(pointSize = NULL, 
    chartType = NULL, yAxis = NULL, xAxis = NULL, errors = NULL, labels = NULL, colors = NULL, 
    initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$pointSize = 0
        self$chartType = ""
        self$yAxis = Factor$new()
        self$xAxis = Factor$new()
        self$errors = list()
        self$labels = list()
        self$colors = list()
    }, initJson = function(json) {
        super$initJson(json)
        self$pointSize = json$pointSize
        self$chartType = json$chartType
        self$yAxis = createObjectFromJson(json$yAxis)
        self$xAxis = createObjectFromJson(json$xAxis)
        self$errors = lapply(json$errors, createObjectFromJson)
        self$labels = lapply(json$labels, createObjectFromJson)
        self$colors = lapply(json$colors, createObjectFromJson)
    }, toTson = function() {
        m = super$toTson()
        m$kind = rtson::tson.scalar(jsonlite::unbox("CubeAxisQuery"))
        m$pointSize = rtson::tson.int(jsonlite::unbox(self$pointSize))
        m$chartType = rtson::tson.scalar(jsonlite::unbox(self$chartType))
        m$yAxis = self$yAxis$toTson()
        m$xAxis = self$xAxis$toTson()
        m$errors = lapply(self$errors, function(each) each$toTson())
        m$labels = lapply(self$labels, function(each) each$toTson())
        m$colors = lapply(self$colors, function(each) each$toTson())
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
