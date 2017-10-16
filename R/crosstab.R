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
        m$kind = rtson::tson.scalar("Crosstab")
        m$axis = self$axis$toTson()
        m$columnTable = self$columnTable$toTson()
        m$filters = self$filters$toTson()
        m$operatorSettings = self$operatorSettings$toTson()
        m$rowTable = self$rowTable$toTson()
        m$taskId = rtson::tson.scalar(self$taskId)
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
