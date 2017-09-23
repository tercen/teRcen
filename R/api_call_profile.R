#' ApiCallProfile
#'
#' @export
#' @format \code{\link{R6Class}} object, super class \code{\link{Profile}}.
#' @field name of type String inherited from super class \code{\link{Profile}}.
#' @field nCalls of type int.
ApiCallProfile <- R6::R6Class("ApiCallProfile", inherit = Profile, public = list(nCalls = NULL, 
    initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$nCalls = 0
    }, initJson = function(json) {
        super$initJson(json)
        self$nCalls = json$nCalls
    }, toTson = function() {
        m = super$toTson()
        m$kind = rtson::tson.scalar("ApiCallProfile")
        m$nCalls = rtson::tson.int(self$nCalls)
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
