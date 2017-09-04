#' IdObject
#'
#' @export
#' @format \code{\link{R6Class}} object, sub classes \code{\link{DataStep}}, \code{\link{ViewDataStep}}, \code{\link{JoinStep}}, \code{\link{CrossTabStep}}, \code{\link{InStep}}, \code{\link{GroupStep}}, \code{\link{OutStep}}, \code{\link{TableStep}}, \code{\link{MeltStep}}, \code{\link{WizardStep}}, \code{\link{NamespaceStep}}, \code{\link{RelationStep}}, \code{\link{ModelStep}}, \code{\link{ViewStep}}, \code{\link{InputPort}}, \code{\link{OutputPort}}, \code{\link{ComputationTask}}, \code{\link{CSVTask}}, \code{\link{CubeQueryTask}}, \code{\link{Team}}, \code{\link{RSourceOperator}}, \code{\link{SourceOperator}}, \code{\link{ExternalOperator}}, \code{\link{CubeQueryTableSchema}}, \code{\link{ComputedTableSchema}}, \code{\link{Operator}}, \code{\link{TableSchema}}, \code{\link{FileDocument}}, \code{\link{Workflow}}, \code{\link{User}}, \code{\link{ProjectDocument}}, \code{\link{Project}}, \code{\link{Task}}, \code{\link{Document}}, \code{\link{UserSecret}}, \code{\link{WhereRelation}}, \code{\link{RenameRelation}}, \code{\link{UnionRelation}}, \code{\link{SimpleRelation}}, \code{\link{InMemoryRelation}}, \code{\link{CompositeRelation}}, \code{\link{GroupByRelation}}, \code{\link{Column}}, \code{\link{Step}}, \code{\link{Port}}, \code{\link{PersistentObject}}, \code{\link{Link}}, \code{\link{Relation}}, \code{\link{ColumnSchema}}.
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
    m$kind = rtson::tson.scalar(jsonlite::unbox("IdObject"))
    m$id = rtson::tson.scalar(jsonlite::unbox(self$id))
    return(m)
}, print = function(...) {
    cat(yaml::as.yaml(self$toTson()))
    invisible(self)
}))
