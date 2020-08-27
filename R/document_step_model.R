#' DocumentStepModel
#'
#' @export
#' @format \code{\link{R6Class}} object, super class \code{\link{StepModel}}.
#' @field documentIds list of type String.
DocumentStepModel <- R6::R6Class("DocumentStepModel", inherit = StepModel, public = list(documentIds = NULL, 
    initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$documentIds = list()
    }, initJson = function(json) {
        super$initJson(json)
        self$documentIds = json$documentIds
    }, toTson = function() {
        m = super$toTson()
        m$kind = tson.scalar("DocumentStepModel")
        m$documentIds = lapply(self$documentIds, function(each) tson.scalar(each))
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
