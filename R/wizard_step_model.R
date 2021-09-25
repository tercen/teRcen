#' WizardStepModel
#'
#' @export
#' @format \code{\link{R6Class}} object, super class \code{\link{StepModel}}.
#' @field namespace of type String.
#' @field description of type String.
#' @field factors list of class \code{\link{MappingFactor}}.
#' @field filters list of class \code{\link{MappingFilter}}.
#' @field steps list of class \code{\link{Step}}.
#' @field defaultFactors list of class \code{\link{MappingFactor}}.
#' @field defaultFilters list of class \code{\link{MappingFilter}}.
WizardStepModel <- R6::R6Class("WizardStepModel", inherit = StepModel, public = list(namespace = NULL, 
    description = NULL, factors = NULL, filters = NULL, steps = NULL, defaultFactors = NULL, 
    defaultFilters = NULL, initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$namespace = ""
        self$description = ""
        self$factors = list()
        self$filters = list()
        self$steps = list()
        self$defaultFactors = list()
        self$defaultFilters = list()
    }, initJson = function(json) {
        super$initJson(json)
        self$namespace = json$namespace
        self$description = json$description
        self$factors = lapply(json$factors, createObjectFromJson)
        self$filters = lapply(json$filters, createObjectFromJson)
        self$steps = lapply(json$steps, createObjectFromJson)
        self$defaultFactors = lapply(json$defaultFactors, createObjectFromJson)
        self$defaultFilters = lapply(json$defaultFilters, createObjectFromJson)
    }, toTson = function() {
        m = super$toTson()
        m$kind = tson.scalar("WizardStepModel")
        m$namespace = tson.scalar(self$namespace)
        m$description = tson.scalar(self$description)
        m$factors = lapply(self$factors, function(each) each$toTson())
        m$filters = lapply(self$filters, function(each) each$toTson())
        m$steps = lapply(self$steps, function(each) each$toTson())
        m$defaultFactors = lapply(self$defaultFactors, function(each) each$toTson())
        m$defaultFilters = lapply(self$defaultFilters, function(each) each$toTson())
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
