#' RProxy
#'
#' @export
#' @format \code{\link{R6Class}} object.
#' @field name of type String.
#' @field targetUrl of type String.
RProxy <- R6::R6Class("RProxy", inherit = Base, public = list(name = NULL, targetUrl = NULL, 
    initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$name = ""
        self$targetUrl = ""
    }, initJson = function(json) {
        super$initJson(json)
        self$name = json$name
        self$targetUrl = json$targetUrl
    }, toTson = function() {
        m = super$toTson()
        m$kind = tson.scalar("RProxy")
        m$name = tson.scalar(self$name)
        m$targetUrl = tson.scalar(self$targetUrl)
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
