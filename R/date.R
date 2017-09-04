#' Date
#'
#' @export
#' @format \code{\link{R6Class}} object.
#' @field value of type String.
Date <- R6::R6Class("Date", inherit = Base, public = list(value = NULL, initialize = function(json = NULL) {
    if (!is.null(json)) {
        self$initJson(json)
    } else {
        self$init()
    }
}, init = function() {
    super$init()
    self$value = ""
}, initJson = function(json) {
    super$initJson(json)
    self$value = json$value
}, toTson = function() {
    m = super$toTson()
    m$kind = rtson::tson.scalar(jsonlite::unbox("Date"))
    m$value = rtson::tson.scalar(jsonlite::unbox(self$value))
    return(m)
}, print = function(...) {
    cat(yaml::as.yaml(self$toTson()))
    invisible(self)
}))
