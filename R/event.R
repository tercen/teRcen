#' Event
#'
#' @export
#' @format \code{\link{R6Class}} object, super class \code{\link{PersistentObject}}, sub classes \code{\link{TaskStateEvent}}, \code{\link{TaskLogEvent}}, \code{\link{TaskProgressEvent}}, \code{\link{TaskEvent}}.
#' @field isDeleted of type bool inherited from super class \code{\link{PersistentObject}}.
#' @field rev of type String inherited from super class \code{\link{PersistentObject}}.
#' @field id of type String inherited from super class \code{\link{IdObject}}.
#' @field date object of class \code{\link{Date}}.
Event <- R6::R6Class("Event", inherit = PersistentObject, public = list(date = NULL, 
    initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$date = Date$new()
    }, initJson = function(json) {
        super$initJson(json)
        self$date = createObjectFromJson(json$date)
    }, toTson = function() {
        m = super$toTson()
        m$kind = rtson::tson.scalar("Event")
        m$date = self$date$toTson()
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
