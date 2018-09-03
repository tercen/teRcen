#' MappingFilter
#'
#' @export
#' @format \code{\link{R6Class}} object.
#' @field name of type String.
#' @field description of type String.
#' @field namedFilter object of class \code{\link{NamedFilter}}.
MappingFilter <- R6::R6Class("MappingFilter", inherit = Base, public = list(name = NULL, 
    description = NULL, namedFilter = NULL, initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$name = ""
        self$description = ""
        self$namedFilter = NamedFilter$new()
    }, initJson = function(json) {
        super$initJson(json)
        self$name = json$name
        self$description = json$description
        self$namedFilter = createObjectFromJson(json$namedFilter)
    }, toTson = function() {
        m = super$toTson()
        m$kind = rtson::tson.scalar("MappingFilter")
        m$name = rtson::tson.scalar(self$name)
        m$description = rtson::tson.scalar(self$description)
        if (!is.null(self$namedFilter)) m$namedFilter = self$namedFilter$toTson()
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
