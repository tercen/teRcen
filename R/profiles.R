#' Profiles
#'
#' @export
#' @format \code{\link{R6Class}} object.
#' @field apiProfile object of class \code{\link{ApiCallProfile}}.
#' @field tableProfile object of class \code{\link{TableProfile}}.
#' @field cpuTimeProfile object of class \code{\link{CpuTimeProfile}}.
#' @field storageProfile object of class \code{\link{StorageProfile}}.
#' @field runProfile object of class \code{\link{RunProfile}}.
Profiles <- R6::R6Class("Profiles", inherit = Base, public = list(apiProfile = NULL, 
    tableProfile = NULL, cpuTimeProfile = NULL, storageProfile = NULL, runProfile = NULL, 
    initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$apiProfile = ApiCallProfile$new()
        self$tableProfile = TableProfile$new()
        self$cpuTimeProfile = CpuTimeProfile$new()
        self$storageProfile = StorageProfile$new()
        self$runProfile = RunProfile$new()
    }, initJson = function(json) {
        super$initJson(json)
        self$apiProfile = createObjectFromJson(json$apiProfile)
        self$tableProfile = createObjectFromJson(json$tableProfile)
        self$cpuTimeProfile = createObjectFromJson(json$cpuTimeProfile)
        self$storageProfile = createObjectFromJson(json$storageProfile)
        self$runProfile = createObjectFromJson(json$runProfile)
    }, toTson = function() {
        m = super$toTson()
        m$kind = rtson::tson.scalar("Profiles")
        m$apiProfile = self$apiProfile$toTson()
        m$tableProfile = self$tableProfile$toTson()
        m$cpuTimeProfile = self$cpuTimeProfile$toTson()
        m$storageProfile = self$storageProfile$toTson()
        m$runProfile = self$runProfile$toTson()
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
