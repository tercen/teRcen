#' TaskDataEvent
#'
#' @export
#' @format \code{\link{R6Class}} object, super class \code{\link{TaskEvent}}.
#' @field taskId of type String inherited from super class \code{\link{TaskEvent}}.
#' @field isDeleted of type bool inherited from super class \code{\link{PersistentObject}}.
#' @field rev of type String inherited from super class \code{\link{PersistentObject}}.
#' @field id of type String inherited from super class \code{\link{IdObject}}.
#' @field bytes of type Uint8List.
#' @field date object of class \code{\link{Date}} inherited from super class \code{\link{Event}}.
TaskDataEvent <- R6::R6Class("TaskDataEvent", inherit = TaskEvent, public = list(bytes = NULL, 
    initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$bytes = NULL
    }, initJson = function(json) {
        super$initJson(json)
        self$bytes = json$bytes
    }, toTson = function() {
        m = super$toTson()
        m$kind = tson.scalar("TaskDataEvent")
        m$bytes = tson.scalar(self$bytes)
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
