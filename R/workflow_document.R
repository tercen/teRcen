#' WorkflowDocument
#'
#' @export
#' @format \code{\link{R6Class}} object, super class \code{\link{FileDocument}}.
#' @field dataUri of type String inherited from super class \code{\link{FileDocument}}.
#' @field size of type int inherited from super class \code{\link{FileDocument}}.
#' @field projectId of type String inherited from super class \code{\link{ProjectDocument}}.
#' @field description of type String inherited from super class \code{\link{Document}}.
#' @field name of type String inherited from super class \code{\link{Document}}.
#' @field createdBy of type String inherited from super class \code{\link{Document}}.
#' @field tags list of type String inherited from super class \code{\link{Document}}.
#' @field version of type String inherited from super class \code{\link{Document}}.
#' @field authors list of type String inherited from super class \code{\link{Document}}.
#' @field isDeleted of type bool inherited from super class \code{\link{PersistentObject}}.
#' @field rev of type String inherited from super class \code{\link{PersistentObject}}.
#' @field id of type String inherited from super class \code{\link{IdObject}}.
#' @field workflowId of type String.
#' @field stepId of type String.
#' @field metadata object of class \code{\link{FileMetadata}} inherited from super class \code{\link{FileDocument}}.
#' @field acl object of class \code{\link{Acl}} inherited from super class \code{\link{Document}}.
#' @field createdDate object of class \code{\link{Date}} inherited from super class \code{\link{Document}}.
#' @field lastModifiedDate object of class \code{\link{Date}} inherited from super class \code{\link{Document}}.
#' @field urls list of class \code{\link{Url}} inherited from super class \code{\link{Document}}.
#' @field meta list of class \code{\link{Pair}} inherited from super class \code{\link{Document}}.
#' @field url object of class \code{\link{Url}} inherited from super class \code{\link{Document}}.
WorkflowDocument <- R6::R6Class("WorkflowDocument", inherit = FileDocument, public = list(workflowId = NULL, 
    stepId = NULL, initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$workflowId = ""
        self$stepId = ""
    }, initJson = function(json) {
        super$initJson(json)
        self$workflowId = json$workflowId
        self$stepId = json$stepId
    }, toTson = function() {
        m = super$toTson()
        m$kind = tson.scalar("WorkflowDocument")
        m$workflowId = tson.scalar(self$workflowId)
        m$stepId = tson.scalar(self$stepId)
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
