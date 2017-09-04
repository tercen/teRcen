#' WizardStepModel
#'
#' @export
#' @format \code{\link{R6Class}} object, super class \code{\link{StepModel}}.
#' @field name of type String.
#' @field description of type String.
#' @field factors list of class \code{\link{MappingFactor}}.
#' @field steps list of class \code{\link{Step}}.
WizardStepModel <- R6::R6Class("WizardStepModel", inherit = StepModel, public = list(name = NULL, 
    description = NULL, factors = NULL, steps = NULL, initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$name = ""
        self$description = ""
        self$factors = list()
        self$steps = list()
    }, initJson = function(json) {
        super$initJson(json)
        self$name = json$name
        self$description = json$description
        self$factors = lapply(json$factors, createObjectFromJson)
        self$steps = lapply(json$steps, createObjectFromJson)
    }, toTson = function() {
        m = super$toTson()
        m$kind = rtson::tson.scalar(jsonlite::unbox("WizardStepModel"))
        m$name = rtson::tson.scalar(jsonlite::unbox(self$name))
        m$description = rtson::tson.scalar(jsonlite::unbox(self$description))
        m$factors = lapply(self$factors, function(each) each$toTson())
        m$steps = lapply(self$steps, function(each) each$toTson())
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
