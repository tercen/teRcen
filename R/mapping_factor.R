#' MappingFactor
#'
#' @export
#' @format \code{\link{R6Class}} object, super class \code{\link{Factor}}.
#' @field name of type String inherited from super class \code{\link{Factor}}.
#' @field type of type String inherited from super class \code{\link{Factor}}.
#' @field description of type String.
#' @field factorName of type String.
#' @field factors list of class \code{\link{Factor}}.
MappingFactor <- R6::R6Class("MappingFactor", inherit = Factor, public = list(description = NULL, 
    factorName = NULL, factors = NULL, initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$description = ""
        self$factorName = ""
        self$factors = list()
    }, initJson = function(json) {
        super$initJson(json)
        self$description = json$description
        self$factorName = json$factorName
        self$factors = lapply(json$factors, createObjectFromJson)
    }, toTson = function() {
        m = super$toTson()
        m$kind = rtson::tson.scalar(jsonlite::unbox("MappingFactor"))
        m$description = rtson::tson.scalar(jsonlite::unbox(self$description))
        m$factorName = rtson::tson.scalar(jsonlite::unbox(self$factorName))
        m$factors = lapply(self$factors, function(each) each$toTson())
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
