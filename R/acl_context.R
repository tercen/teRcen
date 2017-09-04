#' AclContext
#'
#' @export
#' @format \code{\link{R6Class}} object.
#' @field username of type String.
AclContext <- R6::R6Class("AclContext", inherit = Base, public = list(username = NULL, 
    initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$username = ""
    }, initJson = function(json) {
        super$initJson(json)
        self$username = json$username
    }, toTson = function() {
        m = super$toTson()
        m$kind = rtson::tson.scalar(jsonlite::unbox("AclContext"))
        m$username = rtson::tson.scalar(jsonlite::unbox(self$username))
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
