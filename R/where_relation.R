#' WhereRelation
#'
#' @export
#' @format \code{\link{R6Class}} object, super class \code{\link{Relation}}.
#' @field id of type String inherited from super class \code{\link{IdObject}}.
#' @field relation object of class \code{\link{Relation}}.
#' @field filters object of class \code{\link{Filters}}.
WhereRelation <- R6::R6Class("WhereRelation", inherit = Relation, public = list(relation = NULL, 
    filters = NULL, initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$relation = Relation$new()
        self$filters = Filters$new()
    }, initJson = function(json) {
        super$initJson(json)
        self$relation = createObjectFromJson(json$relation)
        self$filters = createObjectFromJson(json$filters)
    }, toTson = function() {
        m = super$toTson()
        m$kind = tson.scalar("WhereRelation")
        if (!is.null(self$relation)) m$relation = self$relation$toTson()
        if (!is.null(self$filters)) m$filters = self$filters$toTson()
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
