#' InMemoryRelation
#'
#' @export
#' @format \code{\link{R6Class}} object, super class \code{\link{Relation}}.
#' @field id of type String inherited from super class \code{\link{IdObject}}.
#' @field inMemoryTable object of class \code{\link{Table}}.
InMemoryRelation <- R6::R6Class("InMemoryRelation", inherit = Relation, public = list(inMemoryTable = NULL, 
    initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$inMemoryTable = Table$new()
    }, initJson = function(json) {
        super$initJson(json)
        self$inMemoryTable = createObjectFromJson(json$inMemoryTable)
    }, toTson = function() {
        m = super$toTson()
        m$kind = tson.scalar("InMemoryRelation")
        if (!is.null(self$inMemoryTable)) m$inMemoryTable = self$inMemoryTable$toTson()
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
