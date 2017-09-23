#' TaskProgressEvent
#'
#' @export
#' @format \code{\link{R6Class}} object, super class \code{\link{TaskEvent}}.
#' @field taskId of type String inherited from super class \code{\link{TaskEvent}}.
#' @field isDeleted of type bool inherited from super class \code{\link{PersistentObject}}.
#' @field rev of type String inherited from super class \code{\link{PersistentObject}}.
#' @field id of type String inherited from super class \code{\link{IdObject}}.
#' @field total of type int.
#' @field actual of type int.
#' @field date object of class \code{\link{Date}} inherited from super class \code{\link{Event}}.
TaskProgressEvent <- R6::R6Class("TaskProgressEvent", inherit = TaskEvent, public = list(total = NULL, 
    actual = NULL, initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$total = 0
        self$actual = 0
    }, initJson = function(json) {
        super$initJson(json)
        self$total = json$total
        self$actual = json$actual
    }, toTson = function() {
        m = super$toTson()
        m$kind = rtson::tson.scalar("TaskProgressEvent")
        m$total = rtson::tson.int(self$total)
        m$actual = rtson::tson.int(self$actual)
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
