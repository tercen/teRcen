#' CSVTask
#'
#' @export
#' @format \code{\link{R6Class}} object, super class \code{\link{Task}}.
#' @field owner of type String inherited from super class \code{\link{Task}}.
#' @field projectId of type String inherited from super class \code{\link{Task}}.
#' @field taskHash of type String inherited from super class \code{\link{Task}}.
#' @field runProfile of type String inherited from super class \code{\link{Task}}.
#' @field isDeleted of type bool inherited from super class \code{\link{PersistentObject}}.
#' @field rev of type String inherited from super class \code{\link{PersistentObject}}.
#' @field id of type String inherited from super class \code{\link{IdObject}}.
#' @field fileDocumentId of type String.
#' @field schemaId of type String.
#' @field state object of class \code{\link{State}} inherited from super class \code{\link{Task}}.
#' @field createdDate object of class \code{\link{Date}} inherited from super class \code{\link{Task}}.
#' @field lastModifiedDate object of class \code{\link{Date}} inherited from super class \code{\link{Task}}.
#' @field runDate object of class \code{\link{Date}} inherited from super class \code{\link{Task}}.
#' @field completedDate object of class \code{\link{Date}} inherited from super class \code{\link{Task}}.
#' @field aclContext object of class \code{\link{AclContext}} inherited from super class \code{\link{Task}}.
CSVTask <- R6::R6Class("CSVTask", inherit = Task, public = list(fileDocumentId = NULL, 
    schemaId = NULL, initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$fileDocumentId = ""
        self$schemaId = ""
    }, initJson = function(json) {
        super$initJson(json)
        self$fileDocumentId = json$fileDocumentId
        self$schemaId = json$schemaId
    }, toTson = function() {
        m = super$toTson()
        m$kind = rtson::tson.scalar("CSVTask")
        m$fileDocumentId = rtson::tson.scalar(self$fileDocumentId)
        m$schemaId = rtson::tson.scalar(self$schemaId)
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
