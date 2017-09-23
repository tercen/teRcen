#' Task
#'
#' @export
#' @format \code{\link{R6Class}} object, super class \code{\link{PersistentObject}}, sub classes \code{\link{ComputationTask}}, \code{\link{CSVTask}}, \code{\link{CubeQueryTask}}.
#' @field isDeleted of type bool inherited from super class \code{\link{PersistentObject}}.
#' @field rev of type String inherited from super class \code{\link{PersistentObject}}.
#' @field id of type String inherited from super class \code{\link{IdObject}}.
#' @field duration of type double.
#' @field owner of type String.
#' @field projectId of type String.
#' @field taskHash of type String.
#' @field runProfile of type String.
#' @field state object of class \code{\link{State}}.
#' @field createdDate object of class \code{\link{Date}}.
#' @field lastModifiedDate object of class \code{\link{Date}}.
#' @field runDate object of class \code{\link{Date}}.
#' @field completedDate object of class \code{\link{Date}}.
#' @field aclContext object of class \code{\link{AclContext}}.
Task <- R6::R6Class("Task", inherit = PersistentObject, public = list(state = NULL, 
    createdDate = NULL, lastModifiedDate = NULL, runDate = NULL, completedDate = NULL, 
    duration = NULL, aclContext = NULL, owner = NULL, projectId = NULL, taskHash = NULL, 
    runProfile = NULL, initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$duration = 0
        self$owner = ""
        self$projectId = ""
        self$taskHash = ""
        self$runProfile = ""
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
        self$projectId = json$projectId
        self$taskHash = json$taskHash
        self$runProfile = json$runProfile
        self$state = createObjectFromJson(json$state)
        self$createdDate = createObjectFromJson(json$createdDate)
        self$lastModifiedDate = createObjectFromJson(json$lastModifiedDate)
        self$runDate = createObjectFromJson(json$runDate)
        self$completedDate = createObjectFromJson(json$completedDate)
        self$aclContext = createObjectFromJson(json$aclContext)
    }, toTson = function() {
        m = super$toTson()
        m$kind = rtson::tson.scalar("Task")
        m$state = self$state$toTson()
        m$createdDate = self$createdDate$toTson()
        m$lastModifiedDate = self$lastModifiedDate$toTson()
        m$runDate = self$runDate$toTson()
        m$completedDate = self$completedDate$toTson()
        m$duration = rtson::tson.scalar(self$duration)
        m$aclContext = self$aclContext$toTson()
        m$owner = rtson::tson.scalar(self$owner)
        m$projectId = rtson::tson.scalar(self$projectId)
        m$taskHash = rtson::tson.scalar(self$taskHash)
        m$runProfile = rtson::tson.scalar(self$runProfile)
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
