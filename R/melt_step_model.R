#' MeltStepModel
#'
#' @export
#' @format \code{\link{R6Class}} object, super class \code{\link{StepModel}}.
#' @field namespace of type String.
#' @field selectionPattern of type String.
#' @field factorType of type String.
#' @field factors list of class \code{\link{Factor}}.
MeltStepModel <- R6::R6Class("MeltStepModel", inherit = StepModel, public = list(factors = NULL, 
    namespace = NULL, selectionPattern = NULL, factorType = NULL, initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$namespace = ""
        self$selectionPattern = ""
        self$factorType = ""
        self$factors = list()
    }, initJson = function(json) {
        super$initJson(json)
        self$namespace = json$namespace
        self$selectionPattern = json$selectionPattern
        self$factorType = json$factorType
        self$factors = lapply(json$factors, createObjectFromJson)
    }, toTson = function() {
        m = super$toTson()
        m$kind = rtson::tson.scalar("MeltStepModel")
        m$factors = lapply(self$factors, function(each) each$toTson())
        m$namespace = rtson::tson.scalar(self$namespace)
        m$selectionPattern = rtson::tson.scalar(self$selectionPattern)
        m$factorType = rtson::tson.scalar(self$factorType)
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
