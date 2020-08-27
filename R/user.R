#' User
#'
#' @export
#' @format \code{\link{R6Class}} object, super class \code{\link{Document}}, sub classes \code{\link{Team}}.
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
#' @field email of type String.
#' @field isValidated of type bool.
#' @field domain of type String.
#' @field roles list of type String.
#' @field invitedByUsername of type String.
#' @field invitationCounts of type int.
#' @field maxInvitation of type int.
#' @field acl object of class \code{\link{Acl}} inherited from super class \code{\link{Document}}.
#' @field createdDate object of class \code{\link{Date}} inherited from super class \code{\link{Document}}.
#' @field lastModifiedDate object of class \code{\link{Date}} inherited from super class \code{\link{Document}}.
#' @field urls list of class \code{\link{Url}} inherited from super class \code{\link{Document}}.
#' @field meta list of class \code{\link{Pair}} inherited from super class \code{\link{Document}}.
#' @field url object of class \code{\link{Url}} inherited from super class \code{\link{Document}}.
#' @field teamAcl object of class \code{\link{Acl}}.
#' @field billingInfo object of class \code{\link{BillingInfo}}.
User <- R6::R6Class("User", inherit = Document, public = list(email = NULL, isValidated = NULL, 
    domain = NULL, roles = NULL, teamAcl = NULL, invitedByUsername = NULL, invitationCounts = NULL, 
    maxInvitation = NULL, billingInfo = NULL, initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$email = ""
        self$isValidated = TRUE
        self$domain = ""
        self$roles = list()
        self$invitedByUsername = ""
        self$invitationCounts = 0
        self$maxInvitation = 0
        self$teamAcl = Acl$new()
        self$billingInfo = BillingInfo$new()
    }, initJson = function(json) {
        super$initJson(json)
        self$email = json$email
        self$isValidated = json$isValidated
        self$domain = json$domain
        self$roles = json$roles
        self$invitedByUsername = json$invitedByUsername
        self$invitationCounts = json$invitationCounts
        self$maxInvitation = json$maxInvitation
        self$teamAcl = createObjectFromJson(json$teamAcl)
        self$billingInfo = createObjectFromJson(json$billingInfo)
    }, toTson = function() {
        m = super$toTson()
        m$kind = tson.scalar("User")
        m$email = tson.scalar(self$email)
        m$isValidated = tson.scalar(self$isValidated)
        m$domain = tson.scalar(self$domain)
        m$roles = lapply(self$roles, function(each) tson.scalar(each))
        if (!is.null(self$teamAcl)) m$teamAcl = self$teamAcl$toTson()
        m$invitedByUsername = tson.scalar(self$invitedByUsername)
        m$invitationCounts = tson.int(self$invitationCounts)
        m$maxInvitation = tson.int(self$maxInvitation)
        if (!is.null(self$billingInfo)) m$billingInfo = self$billingInfo$toTson()
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
