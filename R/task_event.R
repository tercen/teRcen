#' TaskEvent
#'
#' @export
#' @format \code{\link{R6Class}} object, super class \code{\link{Event}}, sub classes \code{\link{TaskLogEvent}}, \code{\link{TaskProgressEvent}}, \code{\link{TaskDataEvent}}, \code{\link{TaskStateEvent}}.
#' @field isDeleted of type bool inherited from super class \code{\link{PersistentObject}}.
#' @field rev of type String inherited from super class \code{\link{PersistentObject}}.
#' @field id of type String inherited from super class \code{\link{IdObject}}.
#' @field taskId of type String.
#' @field date object of class \code{\link{Date}} inherited from super class \code{\link{Event}}.
TaskEvent <- R6::R6Class("TaskEvent", inherit = Event, public = list(taskId = NULL, 
    initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$taskId = ""
    }, initJson = function(json) {
        super$initJson(json)
        self$taskId = json$taskId
    }, toTson = function() {
        m = super$toTson()
        m$kind = tson.scalar("TaskEvent")
        m$taskId = tson.scalar(self$taskId)
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
