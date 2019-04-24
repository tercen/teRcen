#' Acl
#'
#' @export
#' @format \code{\link{R6Class}} object.
#' @field owner of type String.
#' @field aces list of class \code{\link{Ace}}.
Acl <- R6::R6Class("Acl", inherit = Base, public = list(owner = NULL, aces = NULL, 
    initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$owner = ""
        self$aces = list()
    }, initJson = function(json) {
        super$initJson(json)
        self$owner = json$owner
        self$aces = lapply(json$aces, createObjectFromJson)
    }, toTson = function() {
        m = super$toTson()
        m$kind = tson.scalar("Acl")
        m$owner = tson.scalar(self$owner)
        m$aces = lapply(self$aces, function(each) each$toTson())
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
