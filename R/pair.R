#' Pair
#'
#' @export
#' @format \code{\link{R6Class}} object.
#' @field key of type String.
#' @field value of type String.
Pair <- R6::R6Class("Pair", inherit = Base, public = list(key = NULL, value = NULL, 
    initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$key = ""
        self$value = ""
    }, initJson = function(json) {
        super$initJson(json)
        self$key = json$key
        self$value = json$value
    }, toTson = function() {
        m = super$toTson()
        m$kind = rtson::tson.scalar("Pair")
        m$key = rtson::tson.scalar(self$key)
        m$value = rtson::tson.scalar(self$value)
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
