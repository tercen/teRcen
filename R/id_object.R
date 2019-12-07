#' IdObject
#'
#' @export
#' @format \code{\link{R6Class}} object, sub classes \code{\link{DataStep}}, \code{\link{MeltStep}}, \code{\link{JoinStep}}, \code{\link{WizardStep}}, \code{\link{CrossTabStep}}, \code{\link{InStep}}, \code{\link{GroupStep}}, \code{\link{OutStep}}, \code{\link{TableStep}}, \code{\link{NamespaceStep}}, \code{\link{RelationStep}}, \code{\link{ExportStep}}, \code{\link{ModelStep}}, \code{\link{ViewStep}}, \code{\link{InputPort}}, \code{\link{OutputPort}}, \code{\link{GarbageTasks}}, \code{\link{RunComputationTask}}, \code{\link{SaveComputationResultTask}}, \code{\link{ComputationTask}}, \code{\link{ExportWorkflowTask}}, \code{\link{RunWebAppTask}}, \code{\link{CSVTask}}, \code{\link{CubeQueryTask}}, \code{\link{ExportTableTask}}, \code{\link{ImportWorkflowTask}}, \code{\link{TestOperatorTask}}, \code{\link{ImportGitWorkflowTask}}, \code{\link{GlTask}}, \code{\link{ProjectTask}}, \code{\link{CreateGitOperatorTask}}, \code{\link{TaskStateEvent}}, \code{\link{TaskLogEvent}}, \code{\link{TaskProgressEvent}}, \code{\link{TaskDataEvent}}, \code{\link{TaskEvent}}, \code{\link{GenericEvent}}, \code{\link{Team}}, \code{\link{ShinyOperator}}, \code{\link{DockerOperator}}, \code{\link{ROperator}}, \code{\link{WebAppOperator}}, \code{\link{GitOperator}}, \code{\link{CubeQueryTableSchema}}, \code{\link{TableSchema}}, \code{\link{ComputedTableSchema}}, \code{\link{Schema}}, \code{\link{FileDocument}}, \code{\link{Workflow}}, \code{\link{User}}, \code{\link{Operator}}, \code{\link{WorkerEndpoint}}, \code{\link{ProjectDocument}}, \code{\link{Project}}, \code{\link{SubscriptionPlan}}, \code{\link{GarbageObject}}, \code{\link{Task}}, \code{\link{Event}}, \code{\link{Document}}, \code{\link{Lock}}, \code{\link{UserSecret}}, \code{\link{WhereRelation}}, \code{\link{RenameRelation}}, \code{\link{DistinctRelation}}, \code{\link{UnionRelation}}, \code{\link{SimpleRelation}}, \code{\link{InMemoryRelation}}, \code{\link{GatherRelation}}, \code{\link{CompositeRelation}}, \code{\link{GroupByRelation}}, \code{\link{Column}}, \code{\link{StartProcess}}, \code{\link{Step}}, \code{\link{Port}}, \code{\link{PersistentObject}}, \code{\link{Link}}, \code{\link{Relation}}, \code{\link{ColumnSchema}}.
#' @field id of type String.
IdObject <- R6::R6Class("IdObject", inherit = Base, public = list(id = NULL, initialize = function(json = NULL) {
    if (!is.null(json)) {
        self$initJson(json)
    } else {
        self$init()
    }
}, init = function() {
    super$init()
    self$id = ""
}, initJson = function(json) {
    super$initJson(json)
    self$id = json$id
}, toTson = function() {
    m = super$toTson()
    m$kind = tson.scalar("IdObject")
    m$id = tson.scalar(self$id)
    return(m)
}, print = function(...) {
    cat(yaml::as.yaml(self$toTson()))
    invisible(self)
}))
