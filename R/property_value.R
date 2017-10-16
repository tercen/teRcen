#' PropertyValue
#'
#' @export
#' @format \code{\link{R6Class}} object.
#' @field name of type String.
#' @field value of type String.
PropertyValue <- R6::R6Class("PropertyValue", inherit = Base, public = list(name = NULL, 
    value = NULL, initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$name = ""
        self$value = ""
    }, initJson = function(json) {
        super$initJson(json)
        self$name = json$name
        self$value = json$value
    }, toTson = function() {
        m = super$toTson()
        m$kind = rtson::tson.scalar("PropertyValue")
        m$name = rtson::tson.scalar(self$name)
        m$value = rtson::tson.scalar(self$value)
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
