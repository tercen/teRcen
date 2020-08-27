#' Profile
#'
#' @export
#' @format \code{\link{R6Class}} object, sub classes \code{\link{StorageProfile}}, \code{\link{RunProfile}}, \code{\link{CpuTimeProfile}}, \code{\link{TableProfile}}, \code{\link{ApiCallProfile}}.
#' @field name of type String.
Profile <- R6::R6Class("Profile", inherit = Base, public = list(name = NULL, initialize = function(json = NULL) {
    if (!is.null(json)) {
        self$initJson(json)
    } else {
        self$init()
    }
}, init = function() {
    super$init()
    self$name = ""
}, initJson = function(json) {
    super$initJson(json)
    self$name = json$name
}, toTson = function() {
    m = super$toTson()
    m$kind = tson.scalar("Profile")
    m$name = tson.scalar(self$name)
    return(m)
}, print = function(...) {
    cat(yaml::as.yaml(self$toTson()))
    invisible(self)
}))
