#' Labels
#'
#' @export
#' @format \code{\link{R6Class}} object.
#' @field factors list of class \code{\link{Factor}}.
Labels <- R6::R6Class("Labels", inherit = Base, public = list(factors = NULL, initialize = function(json = NULL) {
    if (!is.null(json)) {
        self$initJson(json)
    } else {
        self$init()
    }
}, init = function() {
    super$init()
    self$factors = list()
}, initJson = function(json) {
    super$initJson(json)
    self$factors = lapply(json$factors, createObjectFromJson)
}, toTson = function() {
    m = super$toTson()
    m$kind = rtson::tson.scalar("Labels")
    m$factors = lapply(self$factors, function(each) each$toTson())
    return(m)
}, print = function(...) {
    cat(yaml::as.yaml(self$toTson()))
    invisible(self)
}))
