#' Token
#'
#' @export
#' @format \code{\link{R6Class}} object.
#' @field userId of type String.
#' @field token of type String.
#' @field expiry object of class \code{\link{Date}}.
Token <- R6::R6Class("Token", inherit = Base, public = list(userId = NULL, expiry = NULL, 
    token = NULL, initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$userId = ""
        self$token = ""
        self$expiry = Date$new()
    }, initJson = function(json) {
        super$initJson(json)
        self$userId = json$userId
        self$token = json$token
        self$expiry = createObjectFromJson(json$expiry)
    }, toTson = function() {
        m = super$toTson()
        m$kind = rtson::tson.scalar("Token")
        m$userId = rtson::tson.scalar(self$userId)
        m$expiry = self$expiry$toTson()
        m$token = rtson::tson.scalar(self$token)
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
