#' Team
#'
#' @export
#' @format \code{\link{R6Class}} object, super class \code{\link{User}}.
#' @field email of type String inherited from super class \code{\link{User}}.
#' @field isValidated of type bool inherited from super class \code{\link{User}}.
#' @field roles list of type String inherited from super class \code{\link{User}}.
#' @field invitedByUsername of type String inherited from super class \code{\link{User}}.
#' @field invitationCounts of type int inherited from super class \code{\link{User}}.
#' @field maxInvitation of type int inherited from super class \code{\link{User}}.
#' @field description of type String inherited from super class \code{\link{Document}}.
#' @field name of type String inherited from super class \code{\link{Document}}.
#' @field createdBy of type String inherited from super class \code{\link{Document}}.
#' @field tags list of type String inherited from super class \code{\link{Document}}.
#' @field isDeleted of type bool inherited from super class \code{\link{PersistentObject}}.
#' @field rev of type String inherited from super class \code{\link{PersistentObject}}.
#' @field id of type String inherited from super class \code{\link{IdObject}}.
#' @field owner of type String.
#' @field teamAcl object of class \code{\link{Acl}} inherited from super class \code{\link{User}}.
#' @field acl object of class \code{\link{Acl}} inherited from super class \code{\link{Document}}.
#' @field createdDate object of class \code{\link{Date}} inherited from super class \code{\link{Document}}.
#' @field lastModifiedDate object of class \code{\link{Date}} inherited from super class \code{\link{Document}}.
#' @field urls list of class \code{\link{Url}} inherited from super class \code{\link{Document}}.
Team <- R6::R6Class("Team", inherit = User, public = list(owner = NULL, initialize = function(json = NULL) {
    if (!is.null(json)) {
        self$initJson(json)
    } else {
        self$init()
    }
}, init = function() {
    super$init()
    self$owner = ""
}, initJson = function(json) {
    super$initJson(json)
    self$owner = json$owner
}, toTson = function() {
    m = super$toTson()
    m$kind = rtson::tson.scalar("Team")
    m$owner = rtson::tson.scalar(self$owner)
    return(m)
}, print = function(...) {
    cat(yaml::as.yaml(self$toTson()))
    invisible(self)
}))
