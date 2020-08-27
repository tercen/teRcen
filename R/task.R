#' Task
#'
#' @export
#' @format \code{\link{R6Class}} object, super class \code{\link{PersistentObject}}, sub classes \code{\link{RunComputationTask}}, \code{\link{SaveComputationResultTask}}, \code{\link{ComputationTask}}, \code{\link{ExportWorkflowTask}}, \code{\link{CSVTask}}, \code{\link{CubeQueryTask}}, \code{\link{ImportWorkflowTask}}, \code{\link{TestOperatorTask}}, \code{\link{ImportGitWorkflowTask}}, \code{\link{RunWebAppTask}}, \code{\link{ExportTableTask}}, \code{\link{ProjectTask}}, \code{\link{GlTask}}, \code{\link{CreateGitOperatorTask}}.
#' @field isDeleted of type bool inherited from super class \code{\link{PersistentObject}}.
#' @field rev of type String inherited from super class \code{\link{PersistentObject}}.
#' @field id of type String inherited from super class \code{\link{IdObject}}.
#' @field duration of type double.
#' @field owner of type String.
#' @field taskHash of type String.
#' @field channelId of type String.
#' @field environment list of class \code{\link{Pair}}.
#' @field state object of class \code{\link{State}}.
#' @field createdDate object of class \code{\link{Date}}.
#' @field lastModifiedDate object of class \code{\link{Date}}.
#' @field runDate object of class \code{\link{Date}}.
#' @field completedDate object of class \code{\link{Date}}.
#' @field aclContext object of class \code{\link{AclContext}}.
Task <- R6::R6Class("Task", inherit = PersistentObject, public = list(environment = NULL, 
    state = NULL, createdDate = NULL, lastModifiedDate = NULL, runDate = NULL, completedDate = NULL, 
    duration = NULL, aclContext = NULL, owner = NULL, taskHash = NULL, channelId = NULL, 
    initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$duration = 0
        self$owner = ""
        self$taskHash = ""
        self$channelId = ""
        self$environment = list()
        self$state = State$new()
        self$createdDate = Date$new()
        self$lastModifiedDate = Date$new()
        self$runDate = Date$new()
        self$completedDate = Date$new()
        self$aclContext = AclContext$new()
    }, initJson = function(json) {
        super$initJson(json)
        self$duration = as.double(json$duration)
        self$owner = json$owner
        self$taskHash = json$taskHash
        self$channelId = json$channelId
        self$environment = lapply(json$environment, createObjectFromJson)
        self$state = createObjectFromJson(json$state)
        self$createdDate = createObjectFromJson(json$createdDate)
        self$lastModifiedDate = createObjectFromJson(json$lastModifiedDate)
        self$runDate = createObjectFromJson(json$runDate)
        self$completedDate = createObjectFromJson(json$completedDate)
        self$aclContext = createObjectFromJson(json$aclContext)
    }, toTson = function() {
        m = super$toTson()
        m$kind = tson.scalar("Task")
        m$environment = lapply(self$environment, function(each) each$toTson())
        if (!is.null(self$state)) m$state = self$state$toTson()
        if (!is.null(self$createdDate)) m$createdDate = self$createdDate$toTson()
        if (!is.null(self$lastModifiedDate)) m$lastModifiedDate = self$lastModifiedDate$toTson()
        if (!is.null(self$runDate)) m$runDate = self$runDate$toTson()
        if (!is.null(self$completedDate)) m$completedDate = self$completedDate$toTson()
        m$duration = tson.scalar(self$duration)
        if (!is.null(self$aclContext)) m$aclContext = self$aclContext$toTson()
        m$owner = tson.scalar(self$owner)
        m$taskHash = tson.scalar(self$taskHash)
        m$channelId = tson.scalar(self$channelId)
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
