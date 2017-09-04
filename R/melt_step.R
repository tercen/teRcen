#' MeltStep
#'
#' @export
#' @format \code{\link{R6Class}} object, super class \code{\link{RelationStep}}.
#' @field groupId of type String inherited from super class \code{\link{Step}}.
#' @field name of type String inherited from super class \code{\link{Step}}.
#' @field id of type String inherited from super class \code{\link{IdObject}}.
#' @field model object of class \code{\link{StepModel}} inherited from super class \code{\link{ModelStep}}.
#' @field inputs list of class \code{\link{InputPort}} inherited from super class \code{\link{Step}}.
#' @field outputs list of class \code{\link{OutputPort}} inherited from super class \code{\link{Step}}.
#' @field rectangle object of class \code{\link{Rectangle}} inherited from super class \code{\link{Step}}.
#' @field state object of class \code{\link{StepState}} inherited from super class \code{\link{Step}}.
#' @field model object of class \code{\link{StepModel}} inherited from super class \code{\link{Step}}.
#' @field model object of class \code{\link{MeltStepModel}}.
MeltStep <- R6::R6Class("MeltStep", inherit = RelationStep, public = list(initialize = function(json = NULL) {
    if (!is.null(json)) {
        self$initJson(json)
    } else {
        self$init()
    }
}, init = function() {
    super$init()
    self$model = MeltStepModel$new()
}, initJson = function(json) {
    super$initJson(json)
    self$model = createObjectFromJson(json$model)
}, toTson = function() {
    m = super$toTson()
    m$kind = rtson::tson.scalar(jsonlite::unbox("MeltStep"))
    return(m)
}, print = function(...) {
    cat(yaml::as.yaml(self$toTson()))
    invisible(self)
}))
