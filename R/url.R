#' Url
#'
#' @export
#' @format \code{\link{R6Class}} object.
#' @field uri of type String.
Url <- R6::R6Class("Url", inherit = Base, public = list(uri = NULL, initialize = function(json = NULL) {
    if (!is.null(json)) {
        self$initJson(json)
    } else {
        self$init()
    }
}, init = function() {
    super$init()
    self$uri = ""
}, initJson = function(json) {
    super$initJson(json)
    self$uri = json$uri
}, toTson = function() {
    m = super$toTson()
    m$kind = rtson::tson.scalar("Url")
    m$uri = rtson::tson.scalar(self$uri)
    return(m)
}, print = function(...) {
    cat(yaml::as.yaml(self$toTson()))
    invisible(self)
}))
