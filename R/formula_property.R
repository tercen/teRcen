#' FormulaProperty
#'
#' @export
#' @format \code{\link{R6Class}} object, super class \code{\link{StringProperty}}.
#' @field defaultValue of type String inherited from super class \code{\link{StringProperty}}.
#' @field name of type String inherited from super class \code{\link{Property}}.
#' @field description of type String inherited from super class \code{\link{Property}}.
FormulaProperty <- R6::R6Class("FormulaProperty", inherit = StringProperty, public = list(initialize = function(json = NULL) {
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
    m$kind = tson.scalar("FormulaProperty")
    return(m)
}, print = function(...) {
    cat(yaml::as.yaml(self$toTson()))
    invisible(self)
}))
