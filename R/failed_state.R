#' FailedState
#'
#' @export
#' @format \code{\link{R6Class}} object, super class \code{\link{State}}.
#' @field error of type String.
#' @field reason of type String.
FailedState <- R6::R6Class("FailedState", inherit = State, public = list(error = NULL, 
    reason = NULL, initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$error = ""
        self$reason = ""
    }, initJson = function(json) {
        super$initJson(json)
        self$error = json$error
        self$reason = json$reason
    }, toTson = function() {
        m = super$toTson()
        m$kind = tson.scalar("FailedState")
        m$error = tson.scalar(self$error)
        m$reason = tson.scalar(self$reason)
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
