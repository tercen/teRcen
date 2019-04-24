#' Principal
#'
#' @export
#' @format \code{\link{R6Class}} object.
#' @field principalId of type String.
Principal <- R6::R6Class("Principal", inherit = Base, public = list(principalId = NULL, 
    initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$principalId = ""
    }, initJson = function(json) {
        super$initJson(json)
        self$principalId = json$principalId
    }, toTson = function() {
        m = super$toTson()
        m$kind = tson.scalar("Principal")
        m$principalId = tson.scalar(self$principalId)
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
