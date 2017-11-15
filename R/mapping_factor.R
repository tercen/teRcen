#' MappingFactor
#'
#' @export
#' @format \code{\link{R6Class}} object, super class \code{\link{Factor}}.
#' @field name of type String inherited from super class \code{\link{Factor}}.
#' @field type of type String inherited from super class \code{\link{Factor}}.
#' @field isSingle of type bool.
#' @field description of type String.
#' @field factorName of type String.
#' @field factors list of class \code{\link{Factor}}.
MappingFactor <- R6::R6Class("MappingFactor", inherit = Factor, public = list(isSingle = NULL, 
    description = NULL, factorName = NULL, factors = NULL, initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$isSingle = TRUE
        self$description = ""
        self$factorName = ""
        self$factors = list()
    }, initJson = function(json) {
        super$initJson(json)
        self$isSingle = json$isSingle
        self$description = json$description
        self$factorName = json$factorName
        self$factors = lapply(json$factors, createObjectFromJson)
    }, toTson = function() {
        m = super$toTson()
        m$kind = rtson::tson.scalar("MappingFactor")
        m$isSingle = rtson::tson.scalar(self$isSingle)
        m$description = rtson::tson.scalar(self$description)
        m$factorName = rtson::tson.scalar(self$factorName)
        m$factors = lapply(self$factors, function(each) each$toTson())
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
