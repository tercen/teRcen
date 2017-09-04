#' Task
#'
#' @export
#' @format \code{\link{R6Class}} object, super class \code{\link{PersistentObject}}, sub classes \code{\link{ComputationTask}}, \code{\link{CSVTask}}, \code{\link{CubeQueryTask}}.
#' @field isDeleted of type bool inherited from super class \code{\link{PersistentObject}}.
#' @field rev of type String inherited from super class \code{\link{PersistentObject}}.
#' @field id of type String inherited from super class \code{\link{IdObject}}.
#' @field projectId of type String.
#' @field taskHash of type String.
#' @field state object of class \code{\link{State}}.
#' @field runDate object of class \code{\link{Date}}.
#' @field completedDate object of class \code{\link{Date}}.
#' @field aclContext object of class \code{\link{AclContext}}.
Task <- R6::R6Class("Task", inherit = PersistentObject, public = list(state = NULL, 
    runDate = NULL, completedDate = NULL, aclContext = NULL, projectId = NULL, taskHash = NULL, 
    initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$projectId = ""
        self$taskHash = ""
        self$state = State$new()
        self$runDate = Date$new()
        self$completedDate = Date$new()
        self$aclContext = AclContext$new()
    }, initJson = function(json) {
        super$initJson(json)
        self$projectId = json$projectId
        self$taskHash = json$taskHash
        self$state = createObjectFromJson(json$state)
        self$runDate = createObjectFromJson(json$runDate)
        self$completedDate = createObjectFromJson(json$completedDate)
        self$aclContext = createObjectFromJson(json$aclContext)
    }, toTson = function() {
        m = super$toTson()
        m$kind = rtson::tson.scalar(jsonlite::unbox("Task"))
        m$state = self$state$toTson()
        m$runDate = self$runDate$toTson()
        m$completedDate = self$completedDate$toTson()
        m$aclContext = self$aclContext$toTson()
        m$projectId = rtson::tson.scalar(jsonlite::unbox(self$projectId))
        m$taskHash = rtson::tson.scalar(jsonlite::unbox(self$taskHash))
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
