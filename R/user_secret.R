#' UserSecret
#'
#' @export
#' @format \code{\link{R6Class}} object, super class \code{\link{PersistentObject}}.
#' @field isDeleted of type bool inherited from super class \code{\link{PersistentObject}}.
#' @field rev of type String inherited from super class \code{\link{PersistentObject}}.
#' @field id of type String inherited from super class \code{\link{IdObject}}.
#' @field userId of type String.
#' @field salt of type String.
#' @field hashPassword of type String.
UserSecret <- R6::R6Class("UserSecret", inherit = PersistentObject, public = list(userId = NULL, 
    salt = NULL, hashPassword = NULL, initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$userId = ""
        self$salt = ""
        self$hashPassword = ""
    }, initJson = function(json) {
        super$initJson(json)
        self$userId = json$userId
        self$salt = json$salt
        self$hashPassword = json$hashPassword
    }, toTson = function() {
        m = super$toTson()
        m$kind = tson.scalar("UserSecret")
        m$userId = tson.scalar(self$userId)
        m$salt = tson.scalar(self$salt)
        m$hashPassword = tson.scalar(self$hashPassword)
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
