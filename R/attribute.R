#' Attribute
#'
#' @export
#' @format \code{\link{R6Class}} object, super class \code{\link{Factor}}.
#' @field name of type String inherited from super class \code{\link{Factor}}.
#' @field type of type String inherited from super class \code{\link{Factor}}.
#' @field relationId of type String.
Attribute <- R6::R6Class("Attribute", inherit = Factor, public = list(relationId = NULL, 
    initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$relationId = ""
    }, initJson = function(json) {
        super$initJson(json)
        self$relationId = json$relationId
    }, toTson = function() {
        m = super$toTson()
        m$kind = rtson::tson.scalar(jsonlite::unbox("Attribute"))
        m$relationId = rtson::tson.scalar(jsonlite::unbox(self$relationId))
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
