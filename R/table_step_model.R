#' TableStepModel
#'
#' @export
#' @format \code{\link{R6Class}} object, super class \code{\link{StepModel}}.
#' @field relation object of class \code{\link{Relation}}.
TableStepModel <- R6::R6Class("TableStepModel", inherit = StepModel, public = list(relation = NULL, 
    initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$relation = Relation$new()
    }, initJson = function(json) {
        super$initJson(json)
        self$relation = createObjectFromJson(json$relation)
    }, toTson = function() {
        m = super$toTson()
        m$kind = rtson::tson.scalar("TableStepModel")
        if (!is.null(self$relation)) m$relation = self$relation$toTson()
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
