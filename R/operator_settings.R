#' OperatorSettings
#'
#' @export
#' @format \code{\link{R6Class}} object.
#' @field namespace of type String.
#' @field operatorRef object of class \code{\link{OperatorRef}}.
#' @field environment list of class \code{\link{Pair}}.
OperatorSettings <- R6::R6Class("OperatorSettings", inherit = Base, public = list(namespace = NULL, 
    operatorRef = NULL, environment = NULL, initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$namespace = ""
        self$operatorRef = OperatorRef$new()
        self$environment = list()
    }, initJson = function(json) {
        super$initJson(json)
        self$namespace = json$namespace
        self$operatorRef = createObjectFromJson(json$operatorRef)
        self$environment = lapply(json$environment, createObjectFromJson)
    }, toTson = function() {
        m = super$toTson()
        m$kind = rtson::tson.scalar("OperatorSettings")
        m$namespace = rtson::tson.scalar(self$namespace)
        if (!is.null(self$operatorRef)) m$operatorRef = self$operatorRef$toTson()
        m$environment = lapply(self$environment, function(each) each$toTson())
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
