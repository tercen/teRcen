#' GenericEvent
#'
#' @export
#' @format \code{\link{R6Class}} object, super class \code{\link{Event}}.
#' @field isDeleted of type bool inherited from super class \code{\link{PersistentObject}}.
#' @field rev of type String inherited from super class \code{\link{PersistentObject}}.
#' @field id of type String inherited from super class \code{\link{IdObject}}.
#' @field type of type String.
#' @field content of type String.
#' @field date object of class \code{\link{Date}} inherited from super class \code{\link{Event}}.
GenericEvent <- R6::R6Class("GenericEvent", inherit = Event, public = list(type = NULL, 
    content = NULL, initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$type = ""
        self$content = ""
    }, initJson = function(json) {
        super$initJson(json)
        self$type = json$type
        self$content = json$content
    }, toTson = function() {
        m = super$toTson()
        m$kind = tson.scalar("GenericEvent")
        m$type = tson.scalar(self$type)
        m$content = tson.scalar(self$content)
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
