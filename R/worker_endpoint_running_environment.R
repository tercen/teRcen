#' WorkerEndpointRunningEnvironment
#'
#' @export
#' @format \code{\link{R6Class}} object, super class \code{\link{RunningEnvironment}}.
#' @field workerMachineId of type String.
WorkerEndpointRunningEnvironment <- R6::R6Class("WorkerEndpointRunningEnvironment", 
    inherit = RunningEnvironment, public = list(workerMachineId = NULL, initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$workerMachineId = ""
    }, initJson = function(json) {
        super$initJson(json)
        self$workerMachineId = json$workerMachineId
    }, toTson = function() {
        m = super$toTson()
        m$kind = rtson::tson.scalar("WorkerEndpointRunningEnvironment")
        m$workerMachineId = rtson::tson.scalar(self$workerMachineId)
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
