#' Team
#'
#' @export
#' @format \code{\link{R6Class}} object, super class \code{\link{User}}.
#' @field email of type String inherited from super class \code{\link{User}}.
#' @field isValidated of type bool inherited from super class \code{\link{User}}.
#' @field domain of type String inherited from super class \code{\link{User}}.
#' @field roles list of type String inherited from super class \code{\link{User}}.
#' @field invitedByUsername of type String inherited from super class \code{\link{User}}.
#' @field invitationCounts of type int inherited from super class \code{\link{User}}.
#' @field maxInvitation of type int inherited from super class \code{\link{User}}.
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
#' @field teamAcl object of class \code{\link{Acl}} inherited from super class \code{\link{User}}.
#' @field billingInfo object of class \code{\link{BillingInfo}} inherited from super class \code{\link{User}}.
#' @field acl object of class \code{\link{Acl}} inherited from super class \code{\link{Document}}.
#' @field createdDate object of class \code{\link{Date}} inherited from super class \code{\link{Document}}.
#' @field lastModifiedDate object of class \code{\link{Date}} inherited from super class \code{\link{Document}}.
#' @field urls list of class \code{\link{Url}} inherited from super class \code{\link{Document}}.
#' @field meta list of class \code{\link{Pair}} inherited from super class \code{\link{Document}}.
#' @field url object of class \code{\link{Url}} inherited from super class \code{\link{Document}}.
Team <- R6::R6Class("Team", inherit = User, public = list(initialize = function(json = NULL) {
    if (!is.null(json)) {
        self$initJson(json)
    } else {
        self$init()
    }
}, init = function() {
    super$init()
}, initJson = function(json) {
    super$initJson(json)
}, toTson = function() {
    m = super$toTson()
    m$kind = tson.scalar("Team")
    return(m)
}, print = function(...) {
    cat(yaml::as.yaml(self$toTson()))
    invisible(self)
}))
