#' TaskSummary
#'
#' @export
#' @format \code{\link{R6Class}} object.
#' @field n of type int.
#' @field duration of type double.
TaskSummary <- R6::R6Class("TaskSummary", inherit = Base, public = list(n = NULL, 
    duration = NULL, initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$n = 0
        self$duration = 0
    }, initJson = function(json) {
        super$initJson(json)
        self$n = json$n
        self$duration = as.double(json$duration)
    }, toTson = function() {
        m = super$toTson()
        m$kind = rtson::tson.scalar("TaskSummary")
        m$n = rtson::tson.int(self$n)
        m$duration = rtson::tson.scalar(self$duration)
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
