#' Crosstab
#'
#' @export
#' @format \code{\link{R6Class}} object, super class \code{\link{StepModel}}.
#' @field taskId of type String.
#' @field axis object of class \code{\link{XYAxisList}}.
#' @field columnTable object of class \code{\link{CrosstabTable}}.
#' @field filters object of class \code{\link{Filters}}.
#' @field operatorSettings object of class \code{\link{OperatorSettings}}.
#' @field rowTable object of class \code{\link{CrosstabTable}}.
Crosstab <- R6::R6Class("Crosstab", inherit = StepModel, public = list(axis = NULL, 
    columnTable = NULL, filters = NULL, operatorSettings = NULL, rowTable = NULL, 
    taskId = NULL, initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$taskId = ""
        self$axis = XYAxisList$new()
        self$columnTable = CrosstabTable$new()
        self$filters = Filters$new()
        self$operatorSettings = OperatorSettings$new()
        self$rowTable = CrosstabTable$new()
    }, initJson = function(json) {
        super$initJson(json)
        self$taskId = json$taskId
        self$axis = createObjectFromJson(json$axis)
        self$columnTable = createObjectFromJson(json$columnTable)
        self$filters = createObjectFromJson(json$filters)
        self$operatorSettings = createObjectFromJson(json$operatorSettings)
        self$rowTable = createObjectFromJson(json$rowTable)
    }, toTson = function() {
        m = super$toTson()
        m$kind = tson.scalar("Crosstab")
        if (!is.null(self$axis)) m$axis = self$axis$toTson()
        if (!is.null(self$columnTable)) m$columnTable = self$columnTable$toTson()
        if (!is.null(self$filters)) m$filters = self$filters$toTson()
        if (!is.null(self$operatorSettings)) m$operatorSettings = self$operatorSettings$toTson()
        if (!is.null(self$rowTable)) m$rowTable = self$rowTable$toTson()
        m$taskId = tson.scalar(self$taskId)
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
