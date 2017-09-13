#' Filters
#'
#' @export
#' @format \code{\link{R6Class}} object.
#' @field namedFilters list of class \code{\link{NamedFilter}}.
Filters <- R6::R6Class("Filters", inherit = Base, public = list(namedFilters = NULL, 
    initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$namedFilters = list()
    }, initJson = function(json) {
        super$initJson(json)
        self$namedFilters = lapply(json$namedFilters, createObjectFromJson)
    }, toTson = function() {
        m = super$toTson()
        m$kind = rtson::tson.scalar("Filters")
        m$namedFilters = lapply(self$namedFilters, function(each) each$toTson())
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
