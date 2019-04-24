#' Ace
#'
#' @export
#' @format \code{\link{R6Class}} object.
#' @field principals list of class \code{\link{Principal}}.
#' @field privileges list of class \code{\link{Privilege}}.
Ace <- R6::R6Class("Ace", inherit = Base, public = list(principals = NULL, privileges = NULL, 
    initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$principals = list()
        self$privileges = list()
    }, initJson = function(json) {
        super$initJson(json)
        self$principals = lapply(json$principals, createObjectFromJson)
        self$privileges = lapply(json$privileges, createObjectFromJson)
    }, toTson = function() {
        m = super$toTson()
        m$kind = tson.scalar("Ace")
        m$principals = lapply(self$principals, function(each) each$toTson())
        m$privileges = lapply(self$privileges, function(each) each$toTson())
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
