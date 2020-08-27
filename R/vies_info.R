#' ViesInfo
#'
#' @export
#' @format \code{\link{R6Class}} object.
#' @field countryCode of type String.
#' @field vatNumber of type String.
#' @field requestDate of type String.
#' @field valid of type bool.
#' @field name of type String.
#' @field address of type String.
ViesInfo <- R6::R6Class("ViesInfo", inherit = Base, public = list(countryCode = NULL, 
    vatNumber = NULL, requestDate = NULL, valid = NULL, name = NULL, address = NULL, 
    initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$countryCode = ""
        self$vatNumber = ""
        self$requestDate = ""
        self$valid = TRUE
        self$name = ""
        self$address = ""
    }, initJson = function(json) {
        super$initJson(json)
        self$countryCode = json$countryCode
        self$vatNumber = json$vatNumber
        self$requestDate = json$requestDate
        self$valid = json$valid
        self$name = json$name
        self$address = json$address
    }, toTson = function() {
        m = super$toTson()
        m$kind = tson.scalar("ViesInfo")
        m$countryCode = tson.scalar(self$countryCode)
        m$vatNumber = tson.scalar(self$vatNumber)
        m$requestDate = tson.scalar(self$requestDate)
        m$valid = tson.scalar(self$valid)
        m$name = tson.scalar(self$name)
        m$address = tson.scalar(self$address)
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
