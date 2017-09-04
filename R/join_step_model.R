#' JoinStepModel
#'
#' @export
#' @format \code{\link{R6Class}} object, super class \code{\link{StepModel}}.
#' @field rightPrefix of type String.
#' @field leftFactors list of class \code{\link{Factor}}.
#' @field rightFactors list of class \code{\link{Factor}}.
JoinStepModel <- R6::R6Class("JoinStepModel", inherit = StepModel, public = list(leftFactors = NULL, 
    rightFactors = NULL, rightPrefix = NULL, initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$rightPrefix = ""
        self$leftFactors = list()
        self$rightFactors = list()
    }, initJson = function(json) {
        super$initJson(json)
        self$rightPrefix = json$rightPrefix
        self$leftFactors = lapply(json$leftFactors, createObjectFromJson)
        self$rightFactors = lapply(json$rightFactors, createObjectFromJson)
    }, toTson = function() {
        m = super$toTson()
        m$kind = rtson::tson.scalar(jsonlite::unbox("JoinStepModel"))
        m$leftFactors = lapply(self$leftFactors, function(each) each$toTson())
        m$rightFactors = lapply(self$rightFactors, function(each) each$toTson())
        m$rightPrefix = rtson::tson.scalar(jsonlite::unbox(self$rightPrefix))
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
