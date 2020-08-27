#' SubscriptionPlanService
#'
#' @export
#' @format \code{\link{R6Class}} object.
#' @section Methods:
#' \describe{
#'    \item{\code{getSubscriptionPlans(userId)}}{method}
#'    \item{\code{getPlans(userId)}}{method}
#'    \item{\code{createSubscriptionPlan(userId,plan,successUrl,cancelUrl)}}{method}
#'    \item{\code{setSubscriptionPlanStatus(subscriptionPlanId,status)}}{method}
#'    \item{\code{updatePaymentMethod(subscriptionPlanId,successUrl,cancelUrl)}}{method}
#'    \item{\code{setUpdatePaymentMethodStatus(subscriptionPlanId,status)}}{method}
#'    \item{\code{cancelSubscription(subscriptionPlanId)}}{method}
#'    \item{\code{upgradeSubscription(subscriptionPlanId,plan)}}{method}
#' }
#' 
SubscriptionPlanService <- R6::R6Class("SubscriptionPlanService", inherit = HttpClientService, 
    public = list(initialize = function(baseRestUri, client) {
        super$initialize(baseRestUri, client)
        self$uri = "api/v1/subscription"
    }, findByOwner = function(keys = NULL, useFactory = FALSE) {
        return(self$findKeys("findByOwner", keys = keys, useFactory = useFactory))
    }, findSubscriptionPlanByCheckoutSessionId = function(keys = NULL, useFactory = FALSE) {
        return(self$findKeys("checkoutSessionId", keys = keys, useFactory = useFactory))
    }, getSubscriptionPlans = function(userId) {
        answer = NULL
        response = NULL
        uri = paste0("api/v1/subscription", "/", "getSubscriptionPlans")
        params = list()
        params[["userId"]] = unbox(userId)
        url = self$getServiceUri(uri)
        response = self$client$post(url, body = params)
        if (response$status != 200) {
            self$onResponseError(response, "getSubscriptionPlans")
        } else {
            answer = createObjectFromJson(response$content)
        }
        return(answer)
    }, getPlans = function(userId) {
        answer = NULL
        response = NULL
        uri = paste0("api/v1/subscription", "/", "getPlans")
        params = list()
        params[["userId"]] = unbox(userId)
        url = self$getServiceUri(uri)
        response = self$client$post(url, body = params)
        if (response$status != 200) {
            self$onResponseError(response, "getPlans")
        } else {
            answer = createObjectFromJson(response$content)
        }
        return(answer)
    }, createSubscriptionPlan = function(userId, plan, successUrl, cancelUrl) {
        answer = NULL
        response = NULL
        uri = paste0("api/v1/subscription", "/", "createSubscriptionPlan")
        params = list()
        params[["userId"]] = unbox(userId)
        params[["plan"]] = unbox(plan)
        params[["successUrl"]] = unbox(successUrl)
        params[["cancelUrl"]] = unbox(cancelUrl)
        url = self$getServiceUri(uri)
        response = self$client$post(url, body = params)
        if (response$status != 200) {
            self$onResponseError(response, "createSubscriptionPlan")
        } else {
            answer = createObjectFromJson(response$content)
        }
        return(answer)
    }, setSubscriptionPlanStatus = function(subscriptionPlanId, status) {
        answer = NULL
        response = NULL
        uri = paste0("api/v1/subscription", "/", "setSubscriptionPlanStatus")
        params = list()
        params[["subscriptionPlanId"]] = unbox(subscriptionPlanId)
        params[["status"]] = unbox(status)
        url = self$getServiceUri(uri)
        response = self$client$post(url, body = params)
        if (response$status != 200) {
            self$onResponseError(response, "setSubscriptionPlanStatus")
        } else {
            answer = NULL
        }
        return(answer)
    }, updatePaymentMethod = function(subscriptionPlanId, successUrl, cancelUrl) {
        answer = NULL
        response = NULL
        uri = paste0("api/v1/subscription", "/", "updatePaymentMethod")
        params = list()
        params[["subscriptionPlanId"]] = unbox(subscriptionPlanId)
        params[["successUrl"]] = unbox(successUrl)
        params[["cancelUrl"]] = unbox(cancelUrl)
        url = self$getServiceUri(uri)
        response = self$client$post(url, body = params)
        if (response$status != 200) {
            self$onResponseError(response, "updatePaymentMethod")
        } else {
            answer = createObjectFromJson(response$content)
        }
        return(answer)
    }, setUpdatePaymentMethodStatus = function(subscriptionPlanId, status) {
        answer = NULL
        response = NULL
        uri = paste0("api/v1/subscription", "/", "setUpdatePaymentMethodStatus")
        params = list()
        params[["subscriptionPlanId"]] = unbox(subscriptionPlanId)
        params[["status"]] = unbox(status)
        url = self$getServiceUri(uri)
        response = self$client$post(url, body = params)
        if (response$status != 200) {
            self$onResponseError(response, "setUpdatePaymentMethodStatus")
        } else {
            answer = NULL
        }
        return(answer)
    }, cancelSubscription = function(subscriptionPlanId) {
        answer = NULL
        response = NULL
        uri = paste0("api/v1/subscription", "/", "cancelSubscription")
        params = list()
        params[["subscriptionPlanId"]] = unbox(subscriptionPlanId)
        url = self$getServiceUri(uri)
        response = self$client$post(url, body = params)
        if (response$status != 200) {
            self$onResponseError(response, "cancelSubscription")
        } else {
            answer = NULL
        }
        return(answer)
    }, upgradeSubscription = function(subscriptionPlanId, plan) {
        answer = NULL
        response = NULL
        uri = paste0("api/v1/subscription", "/", "upgradeSubscription")
        params = list()
        params[["subscriptionPlanId"]] = unbox(subscriptionPlanId)
        params[["plan"]] = unbox(plan)
        url = self$getServiceUri(uri)
        response = self$client$post(url, body = params)
        if (response$status != 200) {
            self$onResponseError(response, "upgradeSubscription")
        } else {
            answer = NULL
        }
        return(answer)
    }))
