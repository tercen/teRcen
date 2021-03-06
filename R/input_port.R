#' InputPort
#'
#' @export
#' @format \code{\link{R6Class}} object, super class \code{\link{Port}}.
#' @field linkType of type String inherited from super class \code{\link{Port}}.
#' @field name of type String inherited from super class \code{\link{Port}}.
#' @field id of type String inherited from super class \code{\link{IdObject}}.
InputPort <- R6::R6Class("InputPort", inherit = Port, public = list(initialize = function(json = NULL) {
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
    m$kind = tson.scalar("InputPort")
    return(m)
}, print = function(...) {
    cat(yaml::as.yaml(self$toTson()))
    invisible(self)
}))
