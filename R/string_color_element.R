#' StringColorElement
#'
#' @export
#' @format \code{\link{R6Class}} object, super class \code{\link{ColorElement}}.
#' @field color of type int inherited from super class \code{\link{ColorElement}}.
#' @field stringValue of type String.
StringColorElement <- R6::R6Class("StringColorElement", inherit = ColorElement, public = list(stringValue = NULL, 
    initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$stringValue = ""
    }, initJson = function(json) {
        super$initJson(json)
        self$stringValue = json$stringValue
    }, toTson = function() {
        m = super$toTson()
        m$kind = tson.scalar("StringColorElement")
        m$stringValue = tson.scalar(self$stringValue)
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
