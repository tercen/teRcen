#' Workflow
#'
#' @export
#' @format \code{\link{R6Class}} object, super class \code{\link{ProjectDocument}}.
#' @field projectId of type String inherited from super class \code{\link{ProjectDocument}}.
#' @field description of type String inherited from super class \code{\link{Document}}.
#' @field name of type String inherited from super class \code{\link{Document}}.
#' @field createdBy of type String inherited from super class \code{\link{Document}}.
#' @field tags list of type String inherited from super class \code{\link{Document}}.
#' @field isDeleted of type bool inherited from super class \code{\link{PersistentObject}}.
#' @field rev of type String inherited from super class \code{\link{PersistentObject}}.
#' @field id of type String inherited from super class \code{\link{IdObject}}.
#' @field isApp of type bool.
#' @field isTemplate of type bool.
#' @field acl object of class \code{\link{Acl}} inherited from super class \code{\link{Document}}.
#' @field createdDate object of class \code{\link{Date}} inherited from super class \code{\link{Document}}.
#' @field lastModifiedDate object of class \code{\link{Date}} inherited from super class \code{\link{Document}}.
#' @field urls list of class \code{\link{Url}} inherited from super class \code{\link{Document}}.
#' @field links list of class \code{\link{Link}}.
#' @field steps list of class \code{\link{Step}}.
Workflow <- R6::R6Class("Workflow", inherit = ProjectDocument, public = list(links = NULL, 
    steps = NULL, isApp = NULL, isTemplate = NULL, initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$isApp = TRUE
        self$isTemplate = TRUE
        self$links = list()
        self$steps = list()
    }, initJson = function(json) {
        super$initJson(json)
        self$isApp = json$isApp
        self$isTemplate = json$isTemplate
        self$links = lapply(json$links, createObjectFromJson)
        self$steps = lapply(json$steps, createObjectFromJson)
    }, toTson = function() {
        m = super$toTson()
        m$kind = rtson::tson.scalar("Workflow")
        m$links = lapply(self$links, function(each) each$toTson())
        m$steps = lapply(self$steps, function(each) each$toTson())
        m$isApp = rtson::tson.scalar(self$isApp)
        m$isTemplate = rtson::tson.scalar(self$isTemplate)
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
