#' Rectangle
#'
#' @export
#' @format \code{\link{R6Class}} object.
#' @field extent object of class \code{\link{Point}}.
#' @field topLeft object of class \code{\link{Point}}.
Rectangle <- R6::R6Class("Rectangle", inherit = Base, public = list(extent = NULL, 
    topLeft = NULL, initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$extent = Point$new()
        self$topLeft = Point$new()
    }, initJson = function(json) {
        super$initJson(json)
        self$extent = createObjectFromJson(json$extent)
        self$topLeft = createObjectFromJson(json$topLeft)
    }, toTson = function() {
        m = super$toTson()
        m$kind = rtson::tson.scalar("Rectangle")
        m$extent = self$extent$toTson()
        m$topLeft = self$topLeft$toTson()
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
