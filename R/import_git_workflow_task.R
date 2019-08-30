#' ImportGitWorkflowTask
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
#' @field version of type String.
#' @field workflowId of type String.
#' @field environment list of class \code{\link{Pair}} inherited from super class \code{\link{Task}}.
#' @field state object of class \code{\link{State}} inherited from super class \code{\link{Task}}.
#' @field createdDate object of class \code{\link{Date}} inherited from super class \code{\link{Task}}.
#' @field lastModifiedDate object of class \code{\link{Date}} inherited from super class \code{\link{Task}}.
#' @field runDate object of class \code{\link{Date}} inherited from super class \code{\link{Task}}.
#' @field completedDate object of class \code{\link{Date}} inherited from super class \code{\link{Task}}.
#' @field aclContext object of class \code{\link{AclContext}} inherited from super class \code{\link{Task}}.
#' @field url object of class \code{\link{Url}}.
ImportGitWorkflowTask <- R6::R6Class("ImportGitWorkflowTask", inherit = ProjectTask, 
    public = list(url = NULL, version = NULL, workflowId = NULL, initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$version = ""
        self$workflowId = ""
        self$url = Url$new()
    }, initJson = function(json) {
        super$initJson(json)
        self$version = json$version
        self$workflowId = json$workflowId
        self$url = createObjectFromJson(json$url)
    }, toTson = function() {
        m = super$toTson()
        m$kind = tson.scalar("ImportGitWorkflowTask")
        if (!is.null(self$url)) m$url = self$url$toTson()
        m$version = tson.scalar(self$version)
        m$workflowId = tson.scalar(self$workflowId)
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
