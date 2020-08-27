#' Address
#'
#' @export
#' @format \code{\link{R6Class}} object.
#' @field country of type String.
#' @field state of type String.
#' @field city of type String.
#' @field zipCode of type String.
#' @field address1 of type String.
#' @field address2 of type String.
#' @field phone of type String.
Address <- R6::R6Class("Address", inherit = Base, public = list(country = NULL, state = NULL, 
    city = NULL, zipCode = NULL, address1 = NULL, address2 = NULL, phone = NULL, 
    initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$country = ""
        self$state = ""
        self$city = ""
        self$zipCode = ""
        self$address1 = ""
        self$address2 = ""
        self$phone = ""
    }, initJson = function(json) {
        super$initJson(json)
        self$country = json$country
        self$state = json$state
        self$city = json$city
        self$zipCode = json$zipCode
        self$address1 = json$address1
        self$address2 = json$address2
        self$phone = json$phone
    }, toTson = function() {
        m = super$toTson()
        m$kind = tson.scalar("Address")
        m$country = tson.scalar(self$country)
        m$state = tson.scalar(self$state)
        m$city = tson.scalar(self$city)
        m$zipCode = tson.scalar(self$zipCode)
        m$address1 = tson.scalar(self$address1)
        m$address2 = tson.scalar(self$address2)
        m$phone = tson.scalar(self$phone)
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
