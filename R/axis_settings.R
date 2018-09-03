#' AxisSettings
#'
#' @export
#' @format \code{\link{R6Class}} object.
#' @field properties list of class \code{\link{Property}}.
#' @field propertyValues list of class \code{\link{PropertyValue}}.
AxisSettings <- R6::R6Class("AxisSettings", inherit = Base, public = list(properties = NULL, 
    propertyValues = NULL, initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$properties = list()
        self$propertyValues = list()
    }, initJson = function(json) {
        super$initJson(json)
        self$properties = lapply(json$properties, createObjectFromJson)
        self$propertyValues = lapply(json$propertyValues, createObjectFromJson)
    }, toTson = function() {
        m = super$toTson()
        m$kind = rtson::tson.scalar("AxisSettings")
        m$properties = lapply(self$properties, function(each) each$toTson())
        m$propertyValues = lapply(self$propertyValues, function(each) each$toTson())
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
