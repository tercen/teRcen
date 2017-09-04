#' ModelStep
#'
#' @export
#' @format \code{\link{R6Class}} object, super class \code{\link{Step}}, sub classes \code{\link{DataStep}}, \code{\link{ViewDataStep}}, \code{\link{JoinStep}}, \code{\link{CrossTabStep}}, \code{\link{InStep}}, \code{\link{GroupStep}}, \code{\link{OutStep}}, \code{\link{TableStep}}, \code{\link{MeltStep}}, \code{\link{WizardStep}}, \code{\link{NamespaceStep}}, \code{\link{RelationStep}}.
#' @field groupId of type String inherited from super class \code{\link{Step}}.
#' @field name of type String inherited from super class \code{\link{Step}}.
#' @field id of type String inherited from super class \code{\link{IdObject}}.
#' @field inputs list of class \code{\link{InputPort}} inherited from super class \code{\link{Step}}.
#' @field outputs list of class \code{\link{OutputPort}} inherited from super class \code{\link{Step}}.
#' @field rectangle object of class \code{\link{Rectangle}} inherited from super class \code{\link{Step}}.
#' @field state object of class \code{\link{StepState}} inherited from super class \code{\link{Step}}.
#' @field model object of class \code{\link{StepModel}} inherited from super class \code{\link{Step}}.
#' @field model object of class \code{\link{StepModel}}.
ModelStep <- R6::R6Class("ModelStep", inherit = Step, public = list(initialize = function(json = NULL) {
    if (!is.null(json)) {
        self$initJson(json)
    } else {
        self$init()
    }
}, init = function() {
    super$init()
    self$model = StepModel$new()
}, initJson = function(json) {
    super$initJson(json)
    self$model = createObjectFromJson(json$model)
}, toTson = function() {
    m = super$toTson()
    m$kind = rtson::tson.scalar(jsonlite::unbox("ModelStep"))
    return(m)
}, print = function(...) {
    cat(yaml::as.yaml(self$toTson()))
    invisible(self)
}))
