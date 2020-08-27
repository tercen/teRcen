#' Plan
#'
#' @export
#' @format \code{\link{R6Class}} object.
#' @field name of type String.
#' @field displayName of type String.
#' @field paymentProviderPlanId of type String.
#' @field descriptions list of type String.
#' @field price of type double.
Plan <- R6::R6Class("Plan", inherit = Base, public = list(name = NULL, displayName = NULL, 
    paymentProviderPlanId = NULL, descriptions = NULL, price = NULL, initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$name = ""
        self$displayName = ""
        self$paymentProviderPlanId = ""
        self$descriptions = list()
        self$price = 0
    }, initJson = function(json) {
        super$initJson(json)
        self$name = json$name
        self$displayName = json$displayName
        self$paymentProviderPlanId = json$paymentProviderPlanId
        self$descriptions = json$descriptions
        self$price = as.double(json$price)
    }, toTson = function() {
        m = super$toTson()
        m$kind = tson.scalar("Plan")
        m$name = tson.scalar(self$name)
        m$displayName = tson.scalar(self$displayName)
        m$paymentProviderPlanId = tson.scalar(self$paymentProviderPlanId)
        m$descriptions = lapply(self$descriptions, function(each) tson.scalar(each))
        m$price = tson.scalar(self$price)
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
