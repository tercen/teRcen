#' PersistentObject
#'
#' @export
#' @format \code{\link{R6Class}} object, super class \code{\link{IdObject}}, sub classes \code{\link{GarbageTasks}}, \code{\link{Team}}, \code{\link{RSourceLibrary}}, \code{\link{RenvInstalledLibrary}}, \code{\link{ShinyOperator}}, \code{\link{DockerWebAppOperator}}, \code{\link{DockerOperator}}, \code{\link{ROperator}}, \code{\link{WebAppOperator}}, \code{\link{GitOperator}}, \code{\link{CubeQueryTableSchema}}, \code{\link{TableSchema}}, \code{\link{ComputedTableSchema}}, \code{\link{Issue}}, \code{\link{FileDocument}}, \code{\link{FolderDocument}}, \code{\link{Schema}}, \code{\link{IssueMessage}}, \code{\link{Workflow}}, \code{\link{User}}, \code{\link{RLibrary}}, \code{\link{Operator}}, \code{\link{WorkerEndpoint}}, \code{\link{ProjectDocument}}, \code{\link{Project}}, \code{\link{SubscriptionPlan}}, \code{\link{RunComputationTask}}, \code{\link{SaveComputationResultTask}}, \code{\link{ComputationTask}}, \code{\link{ExportWorkflowTask}}, \code{\link{CSVTask}}, \code{\link{CubeQueryTask}}, \code{\link{ImportWorkflowTask}}, \code{\link{TestOperatorTask}}, \code{\link{ImportGitWorkflowTask}}, \code{\link{RunWebAppTask}}, \code{\link{ExportTableTask}}, \code{\link{ProjectTask}}, \code{\link{GlTask}}, \code{\link{CreateGitOperatorTask}}, \code{\link{TaskLogEvent}}, \code{\link{TaskProgressEvent}}, \code{\link{TaskDataEvent}}, \code{\link{TaskStateEvent}}, \code{\link{TaskEvent}}, \code{\link{GenericEvent}}, \code{\link{GarbageObject}}, \code{\link{Activity}}, \code{\link{Document}}, \code{\link{Lock}}, \code{\link{Task}}, \code{\link{Event}}, \code{\link{UserSecret}}.
#' @field id of type String inherited from super class \code{\link{IdObject}}.
#' @field isDeleted of type bool.
#' @field rev of type String.
PersistentObject <- R6::R6Class("PersistentObject", inherit = IdObject, public = list(isDeleted = NULL, 
    rev = NULL, initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$isDeleted = TRUE
        self$rev = ""
    }, initJson = function(json) {
        super$initJson(json)
        self$isDeleted = json$isDeleted
        self$rev = json$rev
    }, toTson = function() {
        m = super$toTson()
        m$kind = tson.scalar("PersistentObject")
        m$isDeleted = tson.scalar(self$isDeleted)
        m$rev = tson.scalar(self$rev)
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
