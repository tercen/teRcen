#' TableSummary
#'
#' @export
#' @format \code{\link{R6Class}} object.
#' @field n of type double.
#' @field size of type double.
#' @field nr of type double.
#' @field nc of type double.
TableSummary <- R6::R6Class("TableSummary", inherit = Base, public = list(n = NULL, 
    size = NULL, nr = NULL, nc = NULL, initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$n = 0
        self$size = 0
        self$nr = 0
        self$nc = 0
    }, initJson = function(json) {
        super$initJson(json)
        self$n = as.double(json$n)
        self$size = as.double(json$size)
        self$nr = as.double(json$nr)
        self$nc = as.double(json$nc)
    }, toTson = function() {
        m = super$toTson()
        m$kind = rtson::tson.scalar("TableSummary")
        m$n = rtson::tson.scalar(self$n)
        m$size = rtson::tson.scalar(self$size)
        m$nr = rtson::tson.scalar(self$nr)
        m$nc = rtson::tson.scalar(self$nc)
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
