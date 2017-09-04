#' Privilege
#'
#' @export
#' @format \code{\link{R6Class}} object.
#' @field type of type String.
Privilege <- R6::R6Class("Privilege", inherit = Base, public = list(type = NULL, 
    initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$type = ""
    }, initJson = function(json) {
        super$initJson(json)
        self$type = json$type
    }, toTson = function() {
        m = super$toTson()
        m$kind = rtson::tson.scalar(jsonlite::unbox("Privilege"))
        m$type = rtson::tson.scalar(jsonlite::unbox(self$type))
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
