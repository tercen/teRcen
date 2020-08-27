#' Proxy
#'
#' @export
#' @format \code{\link{R6Class}} object.
#' @field name of type String.
#' @field targetUrls list of type String.
Proxy <- R6::R6Class("Proxy", inherit = Base, public = list(name = NULL, targetUrls = NULL, 
    initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$name = ""
        self$targetUrls = list()
    }, initJson = function(json) {
        super$initJson(json)
        self$name = json$name
        self$targetUrls = json$targetUrls
    }, toTson = function() {
        m = super$toTson()
        m$kind = tson.scalar("Proxy")
        m$name = tson.scalar(self$name)
        m$targetUrls = lapply(self$targetUrls, function(each) tson.scalar(each))
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
