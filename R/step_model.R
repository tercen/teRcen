#' StepModel
#'
#' @export
#' @format \code{\link{R6Class}} object, sub classes \code{\link{TableStepModel}}, \code{\link{Crosstab}}, \code{\link{JoinStepModel}}, \code{\link{WizardStepModel}}, \code{\link{MeltStepModel}}.
StepModel <- R6::R6Class("StepModel", inherit = Base, public = list(initialize = function(json = NULL) {
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
    m$kind = rtson::tson.scalar("StepModel")
    return(m)
}, print = function(...) {
    cat(yaml::as.yaml(self$toTson()))
    invisible(self)
}))
