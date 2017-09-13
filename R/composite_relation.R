#' CompositeRelation
#'
#' @export
#' @format \code{\link{R6Class}} object, super class \code{\link{Relation}}.
#' @field id of type String inherited from super class \code{\link{IdObject}}.
#' @field mainRelation object of class \code{\link{Relation}}.
#' @field joinOperators list of class \code{\link{JoinOperator}}.
CompositeRelation <- R6::R6Class("CompositeRelation", inherit = Relation, public = list(mainRelation = NULL, 
    joinOperators = NULL, initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$mainRelation = Relation$new()
        self$joinOperators = list()
    }, initJson = function(json) {
        super$initJson(json)
        self$mainRelation = createObjectFromJson(json$mainRelation)
        self$joinOperators = lapply(json$joinOperators, createObjectFromJson)
    }, toTson = function() {
        m = super$toTson()
        m$kind = rtson::tson.scalar("CompositeRelation")
        m$mainRelation = self$mainRelation$toTson()
        m$joinOperators = lapply(self$joinOperators, function(each) each$toTson())
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
