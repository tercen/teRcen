#' ColorElement
#'
#' @export
#' @format \code{\link{R6Class}} object, sub classes \code{\link{DoubleColorElement}}, \code{\link{StringColorElement}}.
#' @field color of type int.
ColorElement <- R6::R6Class("ColorElement", inherit = Base, public = list(color = NULL, 
    initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$color = 0
    }, initJson = function(json) {
        super$initJson(json)
        self$color = json$color
    }, toTson = function() {
        m = super$toTson()
        m$kind = tson.scalar("ColorElement")
        m$color = tson.int(self$color)
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
