#' ExportTableTask
#'
#' @export
#' @format \code{\link{R6Class}} object, super class \code{\link{ProjectTask}}.
#' @field projectId of type String inherited from super class \code{\link{ProjectTask}}.
#' @field duration of type double inherited from super class \code{\link{Task}}.
#' @field owner of type String inherited from super class \code{\link{Task}}.
#' @field taskHash of type String inherited from super class \code{\link{Task}}.
#' @field runProfile of type String inherited from super class \code{\link{Task}}.
#' @field isDeleted of type bool inherited from super class \code{\link{PersistentObject}}.
#' @field rev of type String inherited from super class \code{\link{PersistentObject}}.
#' @field id of type String inherited from super class \code{\link{IdObject}}.
#' @field exportName of type String.
#' @field schemaIds list of type String.
#' @field channelType of type String.
#' @field channelId of type String.
#' @field exportId of type String.
#' @field namespaces list of type String.
#' @field exportedSchemaIds list of type String.
#' @field state object of class \code{\link{State}} inherited from super class \code{\link{Task}}.
#' @field createdDate object of class \code{\link{Date}} inherited from super class \code{\link{Task}}.
#' @field lastModifiedDate object of class \code{\link{Date}} inherited from super class \code{\link{Task}}.
#' @field runDate object of class \code{\link{Date}} inherited from super class \code{\link{Task}}.
#' @field completedDate object of class \code{\link{Date}} inherited from super class \code{\link{Task}}.
#' @field aclContext object of class \code{\link{AclContext}} inherited from super class \code{\link{Task}}.
ExportTableTask <- R6::R6Class("ExportTableTask", inherit = ProjectTask, public = list(exportName = NULL, 
    schemaIds = NULL, channelType = NULL, channelId = NULL, exportId = NULL, namespaces = NULL, 
    exportedSchemaIds = NULL, initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$exportName = ""
        self$schemaIds = list()
        self$channelType = ""
        self$channelId = ""
        self$exportId = ""
        self$namespaces = list()
        self$exportedSchemaIds = list()
    }, initJson = function(json) {
        super$initJson(json)
        self$exportName = json$exportName
        self$schemaIds = json$schemaIds
        self$channelType = json$channelType
        self$channelId = json$channelId
        self$exportId = json$exportId
        self$namespaces = json$namespaces
        self$exportedSchemaIds = json$exportedSchemaIds
    }, toTson = function() {
        m = super$toTson()
        m$kind = rtson::tson.scalar("ExportTableTask")
        m$exportName = rtson::tson.scalar(self$exportName)
        m$schemaIds = lapply(self$schemaIds, function(each) rtson::tson.scalar(each))
        m$channelType = rtson::tson.scalar(self$channelType)
        m$channelId = rtson::tson.scalar(self$channelId)
        m$exportId = rtson::tson.scalar(self$exportId)
        m$namespaces = lapply(self$namespaces, function(each) rtson::tson.scalar(each))
        m$exportedSchemaIds = lapply(self$exportedSchemaIds, function(each) rtson::tson.scalar(each))
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
