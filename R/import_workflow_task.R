#' ImportWorkflowTask
#'
#' @export
#' @format \code{\link{R6Class}} object, super class \code{\link{ProjectTask}}.
#' @field projectId of type String inherited from super class \code{\link{ProjectTask}}.
#' @field duration of type double inherited from super class \code{\link{Task}}.
#' @field owner of type String inherited from super class \code{\link{Task}}.
#' @field taskHash of type String inherited from super class \code{\link{Task}}.
#' @field channelId of type String inherited from super class \code{\link{Task}}.
#' @field isDeleted of type bool inherited from super class \code{\link{PersistentObject}}.
#' @field rev of type String inherited from super class \code{\link{PersistentObject}}.
#' @field id of type String inherited from super class \code{\link{IdObject}}.
#' @field fileId of type String.
#' @field workflowId of type String.
#' @field environment list of class \code{\link{Pair}} inherited from super class \code{\link{Task}}.
#' @field state object of class \code{\link{State}} inherited from super class \code{\link{Task}}.
#' @field createdDate object of class \code{\link{Date}} inherited from super class \code{\link{Task}}.
#' @field lastModifiedDate object of class \code{\link{Date}} inherited from super class \code{\link{Task}}.
#' @field runDate object of class \code{\link{Date}} inherited from super class \code{\link{Task}}.
#' @field completedDate object of class \code{\link{Date}} inherited from super class \code{\link{Task}}.
#' @field aclContext object of class \code{\link{AclContext}} inherited from super class \code{\link{Task}}.
ImportWorkflowTask <- R6::R6Class("ImportWorkflowTask", inherit = ProjectTask, public = list(fileId = NULL, 
    workflowId = NULL, initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$fileId = ""
        self$workflowId = ""
    }, initJson = function(json) {
        super$initJson(json)
        self$fileId = json$fileId
        self$workflowId = json$workflowId
    }, toTson = function() {
        m = super$toTson()
        m$kind = tson.scalar("ImportWorkflowTask")
        m$fileId = tson.scalar(self$fileId)
        m$workflowId = tson.scalar(self$workflowId)
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
