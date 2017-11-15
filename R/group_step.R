#' GroupStep
#'
#' @export
#' @format \code{\link{R6Class}} object, super class \code{\link{RelationStep}}.
#' @field groupId of type String inherited from super class \code{\link{Step}}.
#' @field name of type String inherited from super class \code{\link{Step}}.
#' @field id of type String inherited from super class \code{\link{IdObject}}.
#' @field appId of type String.
#' @field appName of type String.
#' @field version of type String.
#' @field inputs list of class \code{\link{InputPort}} inherited from super class \code{\link{Step}}.
#' @field outputs list of class \code{\link{OutputPort}} inherited from super class \code{\link{Step}}.
#' @field rectangle object of class \code{\link{Rectangle}} inherited from super class \code{\link{Step}}.
#' @field state object of class \code{\link{StepState}} inherited from super class \code{\link{Step}}.
GroupStep <- R6::R6Class("GroupStep", inherit = RelationStep, public = list(appId = NULL, 
    appName = NULL, version = NULL, initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$appId = ""
        self$appName = ""
        self$version = ""
    }, initJson = function(json) {
        super$initJson(json)
        self$appId = json$appId
        self$appName = json$appName
        self$version = json$version
    }, toTson = function() {
        m = super$toTson()
        m$kind = rtson::tson.scalar("GroupStep")
        m$appId = rtson::tson.scalar(self$appId)
        m$appName = rtson::tson.scalar(self$appName)
        m$version = rtson::tson.scalar(self$version)
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
