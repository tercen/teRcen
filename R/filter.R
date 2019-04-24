#' Filter
#'
#' @export
#' @format \code{\link{R6Class}} object, super class \code{\link{FilterTopExpr}}, sub classes \code{\link{NamedFilter}}.
#' @field logical of type String.
#' @field not of type bool.
#' @field filterExprs list of class \code{\link{FilterTopExpr}}.
Filter <- R6::R6Class("Filter", inherit = FilterTopExpr, public = list(logical = NULL, 
    not = NULL, filterExprs = NULL, initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$logical = ""
        self$not = TRUE
        self$filterExprs = list()
    }, initJson = function(json) {
        super$initJson(json)
        self$logical = json$logical
        self$not = json$not
        self$filterExprs = lapply(json$filterExprs, createObjectFromJson)
    }, toTson = function() {
        m = super$toTson()
        m$kind = tson.scalar("Filter")
        m$logical = tson.scalar(self$logical)
        m$not = tson.scalar(self$not)
        m$filterExprs = lapply(self$filterExprs, function(each) each$toTson())
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
