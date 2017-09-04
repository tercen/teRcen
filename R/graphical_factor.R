#' GraphicalFactor
#'
#' @export
#' @format \code{\link{R6Class}} object.
#' @field factor object of class \code{\link{Factor}}.
#' @field rectangle object of class \code{\link{Rectangle}}.
GraphicalFactor <- R6::R6Class("GraphicalFactor", inherit = Base, public = list(factor = NULL, 
    rectangle = NULL, initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$factor = Factor$new()
        self$rectangle = Rectangle$new()
    }, initJson = function(json) {
        super$initJson(json)
        self$factor = createObjectFromJson(json$factor)
        self$rectangle = createObjectFromJson(json$rectangle)
    }, toTson = function() {
        m = super$toTson()
        m$kind = rtson::tson.scalar(jsonlite::unbox("GraphicalFactor"))
        m$factor = self$factor$toTson()
        m$rectangle = self$rectangle$toTson()
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
