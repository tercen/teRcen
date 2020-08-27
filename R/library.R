#' Library
#'
#' @export
#' @format \code{\link{R6Class}} object, super class \code{\link{PersistentObject}}, sub classes \code{\link{RenvInstalledLibrary}}.
#' @field isDeleted of type bool inherited from super class \code{\link{PersistentObject}}.
#' @field rev of type String inherited from super class \code{\link{PersistentObject}}.
#' @field id of type String inherited from super class \code{\link{IdObject}}.
#' @field description object of class \code{\link{Description}}.
Library <- R6::R6Class("Library", inherit = PersistentObject, public = list(description = NULL, 
    initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$description = Description$new()
    }, initJson = function(json) {
        super$initJson(json)
        self$description = createObjectFromJson(json$description)
    }, toTson = function() {
        m = super$toTson()
        m$kind = tson.scalar("Library")
        if (!is.null(self$description)) m$description = self$description$toTson()
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
