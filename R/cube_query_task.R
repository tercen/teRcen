#' CubeQueryTask
#'
#' @export
#' @format \code{\link{R6Class}} object, super class \code{\link{Task}}, sub classes \code{\link{ComputationTask}}.
#' @field projectId of type String inherited from super class \code{\link{Task}}.
#' @field taskHash of type String inherited from super class \code{\link{Task}}.
#' @field isDeleted of type bool inherited from super class \code{\link{PersistentObject}}.
#' @field rev of type String inherited from super class \code{\link{PersistentObject}}.
#' @field id of type String inherited from super class \code{\link{IdObject}}.
#' @field state object of class \code{\link{State}} inherited from super class \code{\link{Task}}.
#' @field runDate object of class \code{\link{Date}} inherited from super class \code{\link{Task}}.
#' @field completedDate object of class \code{\link{Date}} inherited from super class \code{\link{Task}}.
#' @field aclContext object of class \code{\link{AclContext}} inherited from super class \code{\link{Task}}.
#' @field query object of class \code{\link{CubeQuery}}.
CubeQueryTask <- R6::R6Class("CubeQueryTask", inherit = Task, public = list(query = NULL, 
    initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$query = CubeQuery$new()
    }, initJson = function(json) {
        super$initJson(json)
        self$query = createObjectFromJson(json$query)
    }, toTson = function() {
        m = super$toTson()
        m$kind = rtson::tson.scalar(jsonlite::unbox("CubeQueryTask"))
        m$query = self$query$toTson()
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
