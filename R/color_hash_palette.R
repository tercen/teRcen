#' ColorHashPalette
#'
#' @export
#' @format \code{\link{R6Class}} object, super class \code{\link{CategoryPalette}}.
#' @field backcolor of type int inherited from super class \code{\link{Palette}}.
#' @field colorList object of class \code{\link{ColorList}} inherited from super class \code{\link{CategoryPalette}}.
#' @field stringColorElements list of class \code{\link{StringColorElement}} inherited from super class \code{\link{CategoryPalette}}.
ColorHashPalette <- R6::R6Class("ColorHashPalette", inherit = CategoryPalette, public = list(initialize = function(json = NULL) {
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
    m$kind = rtson::tson.scalar("ColorHashPalette")
    return(m)
}, print = function(...) {
    cat(yaml::as.yaml(self$toTson()))
    invisible(self)
}))
