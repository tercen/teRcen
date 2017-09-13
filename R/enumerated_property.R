#' EnumeratedProperty
#'
#' @export
#' @format \code{\link{R6Class}} object, super class \code{\link{Property}}.
#' @field name of type String inherited from super class \code{\link{Property}}.
EnumeratedProperty <- R6::R6Class("EnumeratedProperty", inherit = Property, public = list(initialize = function(json = NULL) {
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
    m$kind = rtson::tson.scalar("EnumeratedProperty")
    return(m)
}, print = function(...) {
    cat(yaml::as.yaml(self$toTson()))
    invisible(self)
}))
