#' Palette
#'
#' @export
#' @format \code{\link{R6Class}} object, sub classes \code{\link{JetPalette}}, \code{\link{RampPalette}}, \code{\link{CategoryPalette}}.
#' @field backcolor of type int.
#' @field properties list of class \code{\link{PropertyValue}}.
Palette <- R6::R6Class("Palette", inherit = Base, public = list(backcolor = NULL, 
    properties = NULL, initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$backcolor = 0
        self$properties = list()
    }, initJson = function(json) {
        super$initJson(json)
        self$backcolor = json$backcolor
        self$properties = lapply(json$properties, createObjectFromJson)
    }, toTson = function() {
        m = super$toTson()
        m$kind = tson.scalar("Palette")
        m$backcolor = tson.int(self$backcolor)
        m$properties = lapply(self$properties, function(each) each$toTson())
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
