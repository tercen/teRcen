#' Relation
#'
#' @export
#' @format \code{\link{R6Class}} object, super class \code{\link{IdObject}}, sub classes \code{\link{WhereRelation}}, \code{\link{RenameRelation}}, \code{\link{DistinctRelation}}, \code{\link{UnionRelation}}, \code{\link{SimpleRelation}}, \code{\link{InMemoryRelation}}, \code{\link{GatherRelation}}, \code{\link{CompositeRelation}}, \code{\link{GroupByRelation}}.
#' @field id of type String inherited from super class \code{\link{IdObject}}.
Relation <- R6::R6Class("Relation", inherit = IdObject, public = list(initialize = function(json = NULL) {
    if (!is.null(json)) {
        self$initJson(json)
    } else {
        self$init()
    }
}, init = function() {
    super$init()
}, initJson = function(json) {
    super$initJson(json)
}, toTson = function() {
    m = super$toTson()
    m$kind = tson.scalar("Relation")
    return(m)
}, print = function(...) {
    cat(yaml::as.yaml(self$toTson()))
    invisible(self)
}))
