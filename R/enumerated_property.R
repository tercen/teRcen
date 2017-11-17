#' EnumeratedProperty
#'
#' @export
#' @format \code{\link{R6Class}} object, super class \code{\link{StringProperty}}.
#' @field defaultValue of type String inherited from super class \code{\link{StringProperty}}.
#' @field name of type String inherited from super class \code{\link{Property}}.
#' @field description of type String inherited from super class \code{\link{Property}}.
#' @field values list of type String.
EnumeratedProperty <- R6::R6Class("EnumeratedProperty", inherit = StringProperty, 
    public = list(values = NULL, initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$values = list()
    }, initJson = function(json) {
        super$initJson(json)
        self$values = json$values
    }, toTson = function() {
        m = super$toTson()
        m$kind = rtson::tson.scalar("EnumeratedProperty")
        m$values = lapply(self$values, function(each) rtson::tson.scalar(each))
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
