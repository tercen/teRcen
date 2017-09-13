#' OperatorRef
#'
#' @export
#' @format \code{\link{R6Class}} object.
#' @field name of type String.
#' @field operatorId of type String.
#' @field version of type String.
#' @field propertyValues list of class \code{\link{PropertyValue}}.
OperatorRef <- R6::R6Class("OperatorRef", inherit = Base, public = list(name = NULL, 
    operatorId = NULL, version = NULL, propertyValues = NULL, initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$name = ""
        self$operatorId = ""
        self$version = ""
        self$propertyValues = list()
    }, initJson = function(json) {
        super$initJson(json)
        self$name = json$name
        self$operatorId = json$operatorId
        self$version = json$version
        self$propertyValues = lapply(json$propertyValues, createObjectFromJson)
    }, toTson = function() {
        m = super$toTson()
        m$kind = rtson::tson.scalar("OperatorRef")
        m$name = rtson::tson.scalar(self$name)
        m$operatorId = rtson::tson.scalar(self$operatorId)
        m$version = rtson::tson.scalar(self$version)
        m$propertyValues = lapply(self$propertyValues, function(each) each$toTson())
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
