#' NamedFilter
#'
#' @export
#' @format \code{\link{R6Class}} object, super class \code{\link{Filter}}.
#' @field logical of type String inherited from super class \code{\link{Filter}}.
#' @field not of type bool inherited from super class \code{\link{Filter}}.
#' @field name of type String.
#' @field filterExprs list of class \code{\link{FilterTopExpr}} inherited from super class \code{\link{Filter}}.
NamedFilter <- R6::R6Class("NamedFilter", inherit = Filter, public = list(name = NULL, 
    initialize = function(json = NULL) {
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
        m$kind = tson.scalar("NamedFilter")
        m$name = tson.scalar(self$name)
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
