#' Acl
#'
#' @export
#' @format \code{\link{R6Class}} object.
#' @field owner of type String.
#' @field resourceId of type String.
#' @field resourceType of type String.
#' @field aces list of class \code{\link{Ace}}.
Acl <- R6::R6Class("Acl", inherit = Base, public = list(owner = NULL, resourceId = NULL, 
    resourceType = NULL, aces = NULL, initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$owner = ""
        self$resourceId = ""
        self$resourceType = ""
        self$aces = list()
    }, initJson = function(json) {
        super$initJson(json)
        self$owner = json$owner
        self$resourceId = json$resourceId
        self$resourceType = json$resourceType
        self$aces = lapply(json$aces, createObjectFromJson)
    }, toTson = function() {
        m = super$toTson()
        m$kind = rtson::tson.scalar(jsonlite::unbox("Acl"))
        m$owner = rtson::tson.scalar(jsonlite::unbox(self$owner))
        m$resourceId = rtson::tson.scalar(jsonlite::unbox(self$resourceId))
        m$resourceType = rtson::tson.scalar(jsonlite::unbox(self$resourceType))
        m$aces = lapply(self$aces, function(each) each$toTson())
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
