#' NamespaceStep
#'
#' @export
#' @format \code{\link{R6Class}} object, super class \code{\link{RelationStep}}, sub classes \code{\link{DataStep}}, \code{\link{ViewDataStep}}, \code{\link{JoinStep}}, \code{\link{CrossTabStep}}.
#' @field groupId of type String inherited from super class \code{\link{Step}}.
#' @field name of type String inherited from super class \code{\link{Step}}.
#' @field id of type String inherited from super class \code{\link{IdObject}}.
#' @field namespace of type String.
#' @field model object of class \code{\link{StepModel}} inherited from super class \code{\link{ModelStep}}.
#' @field inputs list of class \code{\link{InputPort}} inherited from super class \code{\link{Step}}.
#' @field outputs list of class \code{\link{OutputPort}} inherited from super class \code{\link{Step}}.
#' @field rectangle object of class \code{\link{Rectangle}} inherited from super class \code{\link{Step}}.
#' @field state object of class \code{\link{StepState}} inherited from super class \code{\link{Step}}.
#' @field model object of class \code{\link{StepModel}} inherited from super class \code{\link{Step}}.
NamespaceStep <- R6::R6Class("NamespaceStep", inherit = RelationStep, public = list(namespace = NULL, 
    initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$namespace = ""
    }, initJson = function(json) {
        super$initJson(json)
        self$namespace = json$namespace
    }, toTson = function() {
        m = super$toTson()
        m$kind = rtson::tson.scalar("NamespaceStep")
        m$namespace = rtson::tson.scalar(self$namespace)
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
