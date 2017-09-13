#' CubeQuery
#'
#' @export
#' @format \code{\link{R6Class}} object.
#' @field qtHash of type String.
#' @field columnHash of type String.
#' @field rowHash of type String.
#' @field relation object of class \code{\link{Relation}}.
#' @field colColumns list of class \code{\link{Factor}}.
#' @field rowColumns list of class \code{\link{Factor}}.
#' @field axisQueries list of class \code{\link{CubeAxisQuery}}.
#' @field filters object of class \code{\link{Filters}}.
#' @field operatorSettings object of class \code{\link{OperatorSettings}}.
CubeQuery <- R6::R6Class("CubeQuery", inherit = Base, public = list(relation = NULL, 
    colColumns = NULL, rowColumns = NULL, axisQueries = NULL, filters = NULL, operatorSettings = NULL, 
    qtHash = NULL, columnHash = NULL, rowHash = NULL, initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$qtHash = ""
        self$columnHash = ""
        self$rowHash = ""
        self$relation = Relation$new()
        self$colColumns = list()
        self$rowColumns = list()
        self$axisQueries = list()
        self$filters = Filters$new()
        self$operatorSettings = OperatorSettings$new()
    }, initJson = function(json) {
        super$initJson(json)
        self$qtHash = json$qtHash
        self$columnHash = json$columnHash
        self$rowHash = json$rowHash
        self$relation = createObjectFromJson(json$relation)
        self$colColumns = lapply(json$colColumns, createObjectFromJson)
        self$rowColumns = lapply(json$rowColumns, createObjectFromJson)
        self$axisQueries = lapply(json$axisQueries, createObjectFromJson)
        self$filters = createObjectFromJson(json$filters)
        self$operatorSettings = createObjectFromJson(json$operatorSettings)
    }, toTson = function() {
        m = super$toTson()
        m$kind = rtson::tson.scalar("CubeQuery")
        m$relation = self$relation$toTson()
        m$colColumns = lapply(self$colColumns, function(each) each$toTson())
        m$rowColumns = lapply(self$rowColumns, function(each) each$toTson())
        m$axisQueries = lapply(self$axisQueries, function(each) each$toTson())
        m$filters = self$filters$toTson()
        m$operatorSettings = self$operatorSettings$toTson()
        m$qtHash = rtson::tson.scalar(self$qtHash)
        m$columnHash = rtson::tson.scalar(self$columnHash)
        m$rowHash = rtson::tson.scalar(self$rowHash)
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
