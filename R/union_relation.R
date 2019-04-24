#' UnionRelation
#'
#' @export
#' @format \code{\link{R6Class}} object, super class \code{\link{Relation}}.
#' @field id of type String inherited from super class \code{\link{IdObject}}.
#' @field relations list of class \code{\link{Relation}}.
UnionRelation <- R6::R6Class("UnionRelation", inherit = Relation, public = list(relations = NULL, 
    initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$relations = list()
    }, initJson = function(json) {
        super$initJson(json)
        self$relations = lapply(json$relations, createObjectFromJson)
    }, toTson = function() {
        m = super$toTson()
        m$kind = tson.scalar("UnionRelation")
        m$relations = lapply(self$relations, function(each) each$toTson())
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
