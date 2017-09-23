#' UrlModel
#'
#' @export
#' @format \code{\link{R6Class}} object, super class \code{\link{StepModel}}.
#' @field url of type String.
UrlModel <- R6::R6Class("UrlModel", inherit = StepModel, public = list(url = NULL, 
    initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$url = ""
    }, initJson = function(json) {
        super$initJson(json)
        self$url = json$url
    }, toTson = function() {
        m = super$toTson()
        m$kind = rtson::tson.scalar("UrlModel")
        m$url = rtson::tson.scalar(self$url)
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
