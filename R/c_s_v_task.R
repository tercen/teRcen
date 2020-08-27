#' CSVTask
#'
#' @export
#' @format \code{\link{R6Class}} object, super class \code{\link{ProjectTask}}.
#' @field projectId of type String inherited from super class \code{\link{ProjectTask}}.
#' @field duration of type double inherited from super class \code{\link{Task}}.
#' @field owner of type String inherited from super class \code{\link{Task}}.
#' @field taskHash of type String inherited from super class \code{\link{Task}}.
#' @field channelId of type String inherited from super class \code{\link{Task}}.
#' @field isDeleted of type bool inherited from super class \code{\link{PersistentObject}}.
#' @field rev of type String inherited from super class \code{\link{PersistentObject}}.
#' @field id of type String inherited from super class \code{\link{IdObject}}.
#' @field fileDocumentId of type String.
#' @field schemaId of type String.
#' @field valueName of type String.
#' @field variableName of type String.
#' @field gatherNames list of type String.
#' @field environment list of class \code{\link{Pair}} inherited from super class \code{\link{Task}}.
#' @field state object of class \code{\link{State}} inherited from super class \code{\link{Task}}.
#' @field createdDate object of class \code{\link{Date}} inherited from super class \code{\link{Task}}.
#' @field lastModifiedDate object of class \code{\link{Date}} inherited from super class \code{\link{Task}}.
#' @field runDate object of class \code{\link{Date}} inherited from super class \code{\link{Task}}.
#' @field completedDate object of class \code{\link{Date}} inherited from super class \code{\link{Task}}.
#' @field aclContext object of class \code{\link{AclContext}} inherited from super class \code{\link{Task}}.
#' @field schema object of class \code{\link{Schema}}.
#' @field params object of class \code{\link{CSVParserParam}}.
CSVTask <- R6::R6Class("CSVTask", inherit = ProjectTask, public = list(fileDocumentId = NULL, 
    schemaId = NULL, valueName = NULL, variableName = NULL, gatherNames = NULL, schema = NULL, 
    params = NULL, initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$fileDocumentId = ""
        self$schemaId = ""
        self$valueName = ""
        self$variableName = ""
        self$gatherNames = list()
        self$schema = Schema$new()
        self$params = CSVParserParam$new()
    }, initJson = function(json) {
        super$initJson(json)
        self$fileDocumentId = json$fileDocumentId
        self$schemaId = json$schemaId
        self$valueName = json$valueName
        self$variableName = json$variableName
        self$gatherNames = json$gatherNames
        self$schema = createObjectFromJson(json$schema)
        self$params = createObjectFromJson(json$params)
    }, toTson = function() {
        m = super$toTson()
        m$kind = tson.scalar("CSVTask")
        m$fileDocumentId = tson.scalar(self$fileDocumentId)
        m$schemaId = tson.scalar(self$schemaId)
        m$valueName = tson.scalar(self$valueName)
        m$variableName = tson.scalar(self$variableName)
        m$gatherNames = lapply(self$gatherNames, function(each) tson.scalar(each))
        if (!is.null(self$schema)) m$schema = self$schema$toTson()
        if (!is.null(self$params)) m$params = self$params$toTson()
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
