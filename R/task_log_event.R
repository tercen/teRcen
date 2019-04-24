#' TaskLogEvent
#'
#' @export
#' @format \code{\link{R6Class}} object, super class \code{\link{TaskEvent}}.
#' @field taskId of type String inherited from super class \code{\link{TaskEvent}}.
#' @field isDeleted of type bool inherited from super class \code{\link{PersistentObject}}.
#' @field rev of type String inherited from super class \code{\link{PersistentObject}}.
#' @field id of type String inherited from super class \code{\link{IdObject}}.
#' @field message of type String.
#' @field date object of class \code{\link{Date}} inherited from super class \code{\link{Event}}.
TaskLogEvent <- R6::R6Class("TaskLogEvent", inherit = TaskEvent, public = list(message = NULL, 
    initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$message = ""
    }, initJson = function(json) {
        super$initJson(json)
        self$message = json$message
    }, toTson = function() {
        m = super$toTson()
        m$kind = tson.scalar("TaskLogEvent")
        m$message = tson.scalar(self$message)
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
