#' Property
#'
#' @export
#' @format \code{\link{R6Class}} object, sub classes \code{\link{DoubleProperty}}, \code{\link{IntegerProperty}}, \code{\link{StringProperty}}, \code{\link{EnumeratedProperty}}, \code{\link{BooleanProperty}}.
#' @field name of type String.
Property <- R6::R6Class("Property", inherit = Base, public = list(name = NULL, initialize = function(json = NULL) {
    if (!is.null(json)) {
        self$initJson(json)
    } else {
        self$init()
    }
}, init = function() {
    super$init()
    self$name = ""
}, initJson = function(json) {
    super$initJson(json)
    self$name = json$name
}, toTson = function() {
    m = super$toTson()
    m$kind = rtson::tson.scalar("Property")
    m$name = rtson::tson.scalar(self$name)
    return(m)
}, print = function(...) {
    cat(yaml::as.yaml(self$toTson()))
    invisible(self)
}))
