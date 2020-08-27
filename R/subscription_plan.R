#' SubscriptionPlan
#'
#' @export
#' @format \code{\link{R6Class}} object, super class \code{\link{Document}}.
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
#' @field providerKey of type String.
#' @field paymentProviderPlanId of type String.
#' @field checkoutSessionId of type String.
#' @field subscriptionId of type String.
#' @field status of type String.
#' @field paymentMethodStatus of type String.
#' @field ip of type String.
#' @field acl object of class \code{\link{Acl}} inherited from super class \code{\link{Document}}.
#' @field createdDate object of class \code{\link{Date}} inherited from super class \code{\link{Document}}.
#' @field lastModifiedDate object of class \code{\link{Date}} inherited from super class \code{\link{Document}}.
#' @field urls list of class \code{\link{Url}} inherited from super class \code{\link{Document}}.
#' @field meta list of class \code{\link{Pair}} inherited from super class \code{\link{Document}}.
#' @field url object of class \code{\link{Url}} inherited from super class \code{\link{Document}}.
SubscriptionPlan <- R6::R6Class("SubscriptionPlan", inherit = Document, public = list(providerKey = NULL, 
    paymentProviderPlanId = NULL, checkoutSessionId = NULL, subscriptionId = NULL, 
    status = NULL, paymentMethodStatus = NULL, ip = NULL, initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$providerKey = ""
        self$paymentProviderPlanId = ""
        self$checkoutSessionId = ""
        self$subscriptionId = ""
        self$status = ""
        self$paymentMethodStatus = ""
        self$ip = ""
    }, initJson = function(json) {
        super$initJson(json)
        self$providerKey = json$providerKey
        self$paymentProviderPlanId = json$paymentProviderPlanId
        self$checkoutSessionId = json$checkoutSessionId
        self$subscriptionId = json$subscriptionId
        self$status = json$status
        self$paymentMethodStatus = json$paymentMethodStatus
        self$ip = json$ip
    }, toTson = function() {
        m = super$toTson()
        m$kind = tson.scalar("SubscriptionPlan")
        m$providerKey = tson.scalar(self$providerKey)
        m$paymentProviderPlanId = tson.scalar(self$paymentProviderPlanId)
        m$checkoutSessionId = tson.scalar(self$checkoutSessionId)
        m$subscriptionId = tson.scalar(self$subscriptionId)
        m$status = tson.scalar(self$status)
        m$paymentMethodStatus = tson.scalar(self$paymentMethodStatus)
        m$ip = tson.scalar(self$ip)
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
