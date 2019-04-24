#' ColorList
#'
#' @export
#' @format \code{\link{R6Class}} object.
#' @field name of type String.
ColorList <- R6::R6Class("ColorList", inherit = Base, public = list(name = NULL, 
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
        m$kind = tson.scalar("ColorList")
        m$name = tson.scalar(self$name)
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
