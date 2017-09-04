#' OperatorResult
#'
#' @export
#' @format \code{\link{R6Class}} object.
#' @field tables list of class \code{\link{Table}}.
#' @field joinOperators list of class \code{\link{JoinOperator}}.
OperatorResult <- R6::R6Class("OperatorResult", inherit = Base, public = list(tables = NULL, 
    joinOperators = NULL, initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$tables = list()
        self$joinOperators = list()
    }, initJson = function(json) {
        super$initJson(json)
        self$tables = lapply(json$tables, createObjectFromJson)
        self$joinOperators = lapply(json$joinOperators, createObjectFromJson)
    }, toTson = function() {
        m = super$toTson()
        m$kind = rtson::tson.scalar(jsonlite::unbox("OperatorResult"))
        m$tables = lapply(self$tables, function(each) each$toTson())
        m$joinOperators = lapply(self$joinOperators, function(each) each$toTson())
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
