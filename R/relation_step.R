#' RelationStep
#'
#' @export
#' @format \code{\link{R6Class}} object, super class \code{\link{ModelStep}}, sub classes \code{\link{DataStep}}, \code{\link{MeltStep}}, \code{\link{JoinStep}}, \code{\link{WizardStep}}, \code{\link{CrossTabStep}}, \code{\link{GroupStep}}, \code{\link{InStep}}, \code{\link{OutStep}}, \code{\link{TableStep}}, \code{\link{NamespaceStep}}.
#' @field groupId of type String inherited from super class \code{\link{Step}}.
#' @field name of type String inherited from super class \code{\link{Step}}.
#' @field id of type String inherited from super class \code{\link{IdObject}}.
#' @field inputs list of class \code{\link{InputPort}} inherited from super class \code{\link{Step}}.
#' @field outputs list of class \code{\link{OutputPort}} inherited from super class \code{\link{Step}}.
#' @field rectangle object of class \code{\link{Rectangle}} inherited from super class \code{\link{Step}}.
#' @field state object of class \code{\link{StepState}} inherited from super class \code{\link{Step}}.
RelationStep <- R6::R6Class("RelationStep", inherit = ModelStep, public = list(initialize = function(json = NULL) {
    if (!is.null(json)) {
        self$initJson(json)
    } else {
        self$init()
    }
}, init = function() {
    super$init()
}, initJson = function(json) {
    super$initJson(json)
}, toTson = function() {
    m = super$toTson()
    m$kind = tson.scalar("RelationStep")
    return(m)
}, print = function(...) {
    cat(yaml::as.yaml(self$toTson()))
    invisible(self)
}))
