#' Factor
#'
#' @export
#' @format \code{\link{R6Class}} object, sub classes \code{\link{Attribute}}, \code{\link{MappingFactor}}.
#' @field name of type String.
#' @field type of type String.
Factor <- R6::R6Class("Factor", inherit = Base, public = list(name = NULL, type = NULL, 
    initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$name = ""
        self$type = ""
    }, initJson = function(json) {
        super$initJson(json)
        self$name = json$name
        self$type = json$type
    }, toTson = function() {
        m = super$toTson()
        m$kind = tson.scalar("Factor")
        m$name = tson.scalar(self$name)
        m$type = tson.scalar(self$type)
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
