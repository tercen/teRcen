#' UserSession
#'
#' @export
#' @format \code{\link{R6Class}} object.
#' @field user object of class \code{\link{User}}.
#' @field token object of class \code{\link{Token}}.
UserSession <- R6::R6Class("UserSession", inherit = Base, public = list(user = NULL, 
    token = NULL, initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$user = User$new()
        self$token = Token$new()
    }, initJson = function(json) {
        super$initJson(json)
        self$user = createObjectFromJson(json$user)
        self$token = createObjectFromJson(json$token)
    }, toTson = function() {
        m = super$toTson()
        m$kind = rtson::tson.scalar("UserSession")
        if (!is.null(self$user)) m$user = self$user$toTson()
        if (!is.null(self$token)) m$token = self$token$toTson()
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
