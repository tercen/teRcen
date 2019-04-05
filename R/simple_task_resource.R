#' SimpleTaskResource
#'
#' @export
#' @format \code{\link{R6Class}} object, super class \code{\link{RunningEnvironment}}.
#' @field cpus of type int.
#' @field memory of type double.
SimpleTaskResource <- R6::R6Class("SimpleTaskResource", inherit = RunningEnvironment, 
    public = list(cpus = NULL, memory = NULL, initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$cpus = 0
        self$memory = 0
    }, initJson = function(json) {
        super$initJson(json)
        self$cpus = json$cpus
        self$memory = as.double(json$memory)
    }, toTson = function() {
        m = super$toTson()
        m$kind = rtson::tson.scalar("SimpleTaskResource")
        m$cpus = rtson::tson.int(self$cpus)
        m$memory = rtson::tson.scalar(self$memory)
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
