#' MappingFilter
#'
#' @export
#' @format \code{\link{R6Class}} object.
#' @field name of type String.
#' @field description of type String.
#' @field isRequired of type bool.
#' @field namedFilter object of class \code{\link{NamedFilter}}.
MappingFilter <- R6::R6Class("MappingFilter", inherit = Base, public = list(name = NULL, 
    description = NULL, namedFilter = NULL, isRequired = NULL, initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$name = ""
        self$description = ""
        self$isRequired = TRUE
        self$namedFilter = NamedFilter$new()
    }, initJson = function(json) {
        super$initJson(json)
        self$name = json$name
        self$description = json$description
        self$isRequired = json$isRequired
        self$namedFilter = createObjectFromJson(json$namedFilter)
    }, toTson = function() {
        m = super$toTson()
        m$kind = tson.scalar("MappingFilter")
        m$name = tson.scalar(self$name)
        m$description = tson.scalar(self$description)
        if (!is.null(self$namedFilter)) m$namedFilter = self$namedFilter$toTson()
        m$isRequired = tson.scalar(self$isRequired)
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
