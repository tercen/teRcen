#' OperatorTableResult
#'
#' @export
#' @format \code{\link{R6Class}} object, super class \code{\link{OperatorResult}}.
#' @field joinOperators list of class \code{\link{JoinOperator}} inherited from super class \code{\link{OperatorResult}}.
#' @field tables list of class \code{\link{Table}}.
OperatorTableResult <- R6::R6Class("OperatorTableResult", inherit = OperatorResult, 
    public = list(tables = NULL, initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$tables = list()
    }, initJson = function(json) {
        super$initJson(json)
        self$tables = lapply(json$tables, createObjectFromJson)
    }, toTson = function() {
        m = super$toTson()
        m$kind = rtson::tson.scalar(jsonlite::unbox("OperatorTableResult"))
        m$tables = lapply(self$tables, function(each) each$toTson())
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
