#' StepState
#'
#' @export
#' @format \code{\link{R6Class}} object.
#' @field taskId of type String.
#' @field taskState object of class \code{\link{State}}.
StepState <- R6::R6Class("StepState", inherit = Base, public = list(taskId = NULL, 
    taskState = NULL, initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$taskId = ""
        self$taskState = State$new()
    }, initJson = function(json) {
        super$initJson(json)
        self$taskId = json$taskId
        self$taskState = createObjectFromJson(json$taskState)
    }, toTson = function() {
        m = super$toTson()
        m$kind = rtson::tson.scalar("StepState")
        m$taskId = rtson::tson.scalar(self$taskId)
        m$taskState = self$taskState$toTson()
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
