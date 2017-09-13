#' MeltStepModel
#'
#' @export
#' @format \code{\link{R6Class}} object, super class \code{\link{StepModel}}.
#' @field variableName of type String.
#' @field valueName of type String.
#' @field factors list of class \code{\link{Factor}}.
MeltStepModel <- R6::R6Class("MeltStepModel", inherit = StepModel, public = list(factors = NULL, 
    variableName = NULL, valueName = NULL, initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$variableName = ""
        self$valueName = ""
        self$factors = list()
    }, initJson = function(json) {
        super$initJson(json)
        self$variableName = json$variableName
        self$valueName = json$valueName
        self$factors = lapply(json$factors, createObjectFromJson)
    }, toTson = function() {
        m = super$toTson()
        m$kind = rtson::tson.scalar("MeltStepModel")
        m$factors = lapply(self$factors, function(each) each$toTson())
        m$variableName = rtson::tson.scalar(self$variableName)
        m$valueName = rtson::tson.scalar(self$valueName)
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
