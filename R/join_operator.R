#' JoinOperator
#'
#' @export
#' @format \code{\link{R6Class}} object.
#' @field leftPair object of class \code{\link{ColumnPair}}.
#' @field rightRelation object of class \code{\link{Relation}}.
JoinOperator <- R6::R6Class("JoinOperator", inherit = Base, public = list(leftPair = NULL, 
    rightRelation = NULL, initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$leftPair = ColumnPair$new()
        self$rightRelation = Relation$new()
    }, initJson = function(json) {
        super$initJson(json)
        self$leftPair = createObjectFromJson(json$leftPair)
        self$rightRelation = createObjectFromJson(json$rightRelation)
    }, toTson = function() {
        m = super$toTson()
        m$kind = rtson::tson.scalar("JoinOperator")
        m$leftPair = self$leftPair$toTson()
        m$rightRelation = self$rightRelation$toTson()
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
