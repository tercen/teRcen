#' BillingInfo
#'
#' @export
#' @format \code{\link{R6Class}} object.
#' @field firstName of type String.
#' @field lastName of type String.
#' @field companyName of type String.
#' @field taxId object of class \code{\link{TaxId}}.
#' @field address object of class \code{\link{Address}}.
BillingInfo <- R6::R6Class("BillingInfo", inherit = Base, public = list(firstName = NULL, 
    lastName = NULL, companyName = NULL, taxId = NULL, address = NULL, initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$firstName = ""
        self$lastName = ""
        self$companyName = ""
        self$taxId = TaxId$new()
        self$address = Address$new()
    }, initJson = function(json) {
        super$initJson(json)
        self$firstName = json$firstName
        self$lastName = json$lastName
        self$companyName = json$companyName
        self$taxId = createObjectFromJson(json$taxId)
        self$address = createObjectFromJson(json$address)
    }, toTson = function() {
        m = super$toTson()
        m$kind = tson.scalar("BillingInfo")
        m$firstName = tson.scalar(self$firstName)
        m$lastName = tson.scalar(self$lastName)
        m$companyName = tson.scalar(self$companyName)
        if (!is.null(self$taxId)) m$taxId = self$taxId$toTson()
        if (!is.null(self$address)) m$address = self$address$toTson()
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
