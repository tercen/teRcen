#' RLibrary
#'
#' @export
#' @format \code{\link{R6Class}} object, super class \code{\link{Document}}, sub classes \code{\link{RSourceLibrary}}, \code{\link{RenvInstalledLibrary}}.
#' @field description of type String inherited from super class \code{\link{Document}}.
#' @field name of type String inherited from super class \code{\link{Document}}.
#' @field createdBy of type String inherited from super class \code{\link{Document}}.
#' @field tags list of type String inherited from super class \code{\link{Document}}.
#' @field version of type String inherited from super class \code{\link{Document}}.
#' @field authors list of type String inherited from super class \code{\link{Document}}.
#' @field isPublic of type bool inherited from super class \code{\link{Document}}.
#' @field isDeleted of type bool inherited from super class \code{\link{PersistentObject}}.
#' @field rev of type String inherited from super class \code{\link{PersistentObject}}.
#' @field id of type String inherited from super class \code{\link{IdObject}}.
#' @field acl object of class \code{\link{Acl}} inherited from super class \code{\link{Document}}.
#' @field createdDate object of class \code{\link{Date}} inherited from super class \code{\link{Document}}.
#' @field lastModifiedDate object of class \code{\link{Date}} inherited from super class \code{\link{Document}}.
#' @field urls list of class \code{\link{Url}} inherited from super class \code{\link{Document}}.
#' @field meta list of class \code{\link{Pair}} inherited from super class \code{\link{Document}}.
#' @field url object of class \code{\link{Url}} inherited from super class \code{\link{Document}}.
#' @field rDescription object of class \code{\link{RDescription}}.
RLibrary <- R6::R6Class("RLibrary", inherit = Document, public = list(rDescription = NULL, 
    initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$rDescription = RDescription$new()
    }, initJson = function(json) {
        super$initJson(json)
        self$rDescription = createObjectFromJson(json$rDescription)
    }, toTson = function() {
        m = super$toTson()
        m$kind = tson.scalar("RLibrary")
        if (!is.null(self$rDescription)) m$rDescription = self$rDescription$toTson()
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
