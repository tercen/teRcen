#' Colors
#'
#' @export
#' @format \code{\link{R6Class}} object.
#' @field factors list of class \code{\link{Factor}}.
#' @field palette object of class \code{\link{Palette}}.
Colors <- R6::R6Class("Colors", inherit = Base, public = list(factors = NULL, palette = NULL, 
    initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$factors = list()
        self$palette = Palette$new()
    }, initJson = function(json) {
        super$initJson(json)
        self$factors = lapply(json$factors, createObjectFromJson)
        self$palette = createObjectFromJson(json$palette)
    }, toTson = function() {
        m = super$toTson()
        m$kind = rtson::tson.scalar("Colors")
        m$factors = lapply(self$factors, function(each) each$toTson())
        m$palette = self$palette$toTson()
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
