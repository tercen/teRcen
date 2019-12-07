#' OperatorUnitTest
#'
#' @export
#' @format \code{\link{R6Class}} object.
#' @field name of type String.
#' @field namespace of type String.
#' @field inputDataUri of type String.
#' @field outputDataUri list of type String.
#' @field columns list of type String.
#' @field rows list of type String.
#' @field colors list of type String.
#' @field labels list of type String.
#' @field yAxis of type String.
#' @field xAxis of type String.
OperatorUnitTest <- R6::R6Class("OperatorUnitTest", inherit = Base, public = list(name = NULL, 
    namespace = NULL, inputDataUri = NULL, outputDataUri = NULL, columns = NULL, 
    rows = NULL, colors = NULL, labels = NULL, yAxis = NULL, xAxis = NULL, initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$name = ""
        self$namespace = ""
        self$inputDataUri = ""
        self$outputDataUri = list()
        self$columns = list()
        self$rows = list()
        self$colors = list()
        self$labels = list()
        self$yAxis = ""
        self$xAxis = ""
    }, initJson = function(json) {
        super$initJson(json)
        self$name = json$name
        self$namespace = json$namespace
        self$inputDataUri = json$inputDataUri
        self$outputDataUri = json$outputDataUri
        self$columns = json$columns
        self$rows = json$rows
        self$colors = json$colors
        self$labels = json$labels
        self$yAxis = json$yAxis
        self$xAxis = json$xAxis
    }, toTson = function() {
        m = super$toTson()
        m$kind = tson.scalar("OperatorUnitTest")
        m$name = tson.scalar(self$name)
        m$namespace = tson.scalar(self$namespace)
        m$inputDataUri = tson.scalar(self$inputDataUri)
        m$outputDataUri = lapply(self$outputDataUri, function(each) tson.scalar(each))
        m$columns = lapply(self$columns, function(each) tson.scalar(each))
        m$rows = lapply(self$rows, function(each) tson.scalar(each))
        m$colors = lapply(self$colors, function(each) tson.scalar(each))
        m$labels = lapply(self$labels, function(each) tson.scalar(each))
        m$yAxis = tson.scalar(self$yAxis)
        m$xAxis = tson.scalar(self$xAxis)
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
