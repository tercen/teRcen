#' ProjectTask
#'
#' @export
#' @format \code{\link{R6Class}} object, super class \code{\link{Task}}, sub classes \code{\link{ComputationTask}}, \code{\link{RunComputationTask}}, \code{\link{SaveComputationResultTask}}, \code{\link{ExportWorkflowTask}}, \code{\link{RunWebAppTask}}, \code{\link{CSVTask}}, \code{\link{CubeQueryTask}}, \code{\link{ExportTableTask}}, \code{\link{ImportWorkflowTask}}, \code{\link{ImportGitWorkflowTask}}.
#' @field duration of type double inherited from super class \code{\link{Task}}.
#' @field owner of type String inherited from super class \code{\link{Task}}.
#' @field taskHash of type String inherited from super class \code{\link{Task}}.
#' @field isDeleted of type bool inherited from super class \code{\link{PersistentObject}}.
#' @field rev of type String inherited from super class \code{\link{PersistentObject}}.
#' @field id of type String inherited from super class \code{\link{IdObject}}.
#' @field projectId of type String.
#' @field environment list of class \code{\link{Pair}} inherited from super class \code{\link{Task}}.
#' @field state object of class \code{\link{State}} inherited from super class \code{\link{Task}}.
#' @field createdDate object of class \code{\link{Date}} inherited from super class \code{\link{Task}}.
#' @field lastModifiedDate object of class \code{\link{Date}} inherited from super class \code{\link{Task}}.
#' @field runDate object of class \code{\link{Date}} inherited from super class \code{\link{Task}}.
#' @field completedDate object of class \code{\link{Date}} inherited from super class \code{\link{Task}}.
#' @field aclContext object of class \code{\link{AclContext}} inherited from super class \code{\link{Task}}.
ProjectTask <- R6::R6Class("ProjectTask", inherit = Task, public = list(projectId = NULL, 
    initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$projectId = ""
    }, initJson = function(json) {
        super$initJson(json)
        self$projectId = json$projectId
    }, toTson = function() {
        m = super$toTson()
        m$kind = tson.scalar("ProjectTask")
        m$projectId = tson.scalar(self$projectId)
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
