#' PersistentObject
#'
#' @export
#' @format \code{\link{R6Class}} object, super class \code{\link{IdObject}}, sub classes \code{\link{ComputationTask}}, \code{\link{CSVTask}}, \code{\link{CubeQueryTask}}, \code{\link{Team}}, \code{\link{RSourceOperator}}, \code{\link{SourceOperator}}, \code{\link{ExternalOperator}}, \code{\link{CubeQueryTableSchema}}, \code{\link{ComputedTableSchema}}, \code{\link{Operator}}, \code{\link{TableSchema}}, \code{\link{FileDocument}}, \code{\link{Workflow}}, \code{\link{User}}, \code{\link{ProjectDocument}}, \code{\link{Project}}, \code{\link{Task}}, \code{\link{Document}}, \code{\link{UserSecret}}.
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
        m$kind = rtson::tson.scalar(jsonlite::unbox("PersistentObject"))
        m$isDeleted = rtson::tson.scalar(jsonlite::unbox(self$isDeleted))
        m$rev = rtson::tson.scalar(jsonlite::unbox(self$rev))
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
