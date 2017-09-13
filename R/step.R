#' Step
#'
#' @export
#' @format \code{\link{R6Class}} object, super class \code{\link{IdObject}}, sub classes \code{\link{DataStep}}, \code{\link{ViewDataStep}}, \code{\link{JoinStep}}, \code{\link{CrossTabStep}}, \code{\link{InStep}}, \code{\link{GroupStep}}, \code{\link{OutStep}}, \code{\link{TableStep}}, \code{\link{MeltStep}}, \code{\link{WizardStep}}, \code{\link{NamespaceStep}}, \code{\link{RelationStep}}, \code{\link{ModelStep}}, \code{\link{ViewStep}}.
#' @field id of type String inherited from super class \code{\link{IdObject}}.
#' @field groupId of type String.
#' @field name of type String.
#' @field inputs list of class \code{\link{InputPort}}.
#' @field outputs list of class \code{\link{OutputPort}}.
#' @field rectangle object of class \code{\link{Rectangle}}.
#' @field state object of class \code{\link{StepState}}.
#' @field model object of class \code{\link{StepModel}}.
Step <- R6::R6Class("Step", inherit = IdObject, public = list(groupId = NULL, name = NULL, 
    inputs = NULL, outputs = NULL, rectangle = NULL, state = NULL, model = NULL, 
    initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$groupId = ""
        self$name = ""
        self$inputs = list()
        self$outputs = list()
        self$rectangle = Rectangle$new()
        self$state = StepState$new()
        self$model = StepModel$new()
    }, initJson = function(json) {
        super$initJson(json)
        self$groupId = json$groupId
        self$name = json$name
        self$inputs = lapply(json$inputs, createObjectFromJson)
        self$outputs = lapply(json$outputs, createObjectFromJson)
        self$rectangle = createObjectFromJson(json$rectangle)
        self$state = createObjectFromJson(json$state)
        self$model = createObjectFromJson(json$model)
    }, toTson = function() {
        m = super$toTson()
        m$kind = rtson::tson.scalar("Step")
        m$groupId = rtson::tson.scalar(self$groupId)
        m$name = rtson::tson.scalar(self$name)
        m$inputs = lapply(self$inputs, function(each) each$toTson())
        m$outputs = lapply(self$outputs, function(each) each$toTson())
        m$rectangle = self$rectangle$toTson()
        m$state = self$state$toTson()
        m$model = self$model$toTson()
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
