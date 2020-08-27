#' Activity
#'
#' @export
#' @format \code{\link{R6Class}} object, super class \code{\link{PersistentObject}}.
#' @field isDeleted of type bool inherited from super class \code{\link{PersistentObject}}.
#' @field rev of type String inherited from super class \code{\link{PersistentObject}}.
#' @field id of type String inherited from super class \code{\link{IdObject}}.
#' @field type of type String.
#' @field objectKind of type String.
#' @field teamId of type String.
#' @field projectId of type String.
#' @field userId of type String.
#' @field projectName of type String.
#' @field isPublic of type bool.
#' @field date object of class \code{\link{Date}}.
#' @field properties list of class \code{\link{Pair}}.
Activity <- R6::R6Class("Activity", inherit = PersistentObject, public = list(type = NULL, 
    objectKind = NULL, date = NULL, teamId = NULL, projectId = NULL, userId = NULL, 
    projectName = NULL, isPublic = NULL, properties = NULL, initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$type = ""
        self$objectKind = ""
        self$teamId = ""
        self$projectId = ""
        self$userId = ""
        self$projectName = ""
        self$isPublic = TRUE
        self$date = Date$new()
        self$properties = list()
    }, initJson = function(json) {
        super$initJson(json)
        self$type = json$type
        self$objectKind = json$objectKind
        self$teamId = json$teamId
        self$projectId = json$projectId
        self$userId = json$userId
        self$projectName = json$projectName
        self$isPublic = json$isPublic
        self$date = createObjectFromJson(json$date)
        self$properties = lapply(json$properties, createObjectFromJson)
    }, toTson = function() {
        m = super$toTson()
        m$kind = tson.scalar("Activity")
        m$type = tson.scalar(self$type)
        m$objectKind = tson.scalar(self$objectKind)
        if (!is.null(self$date)) m$date = self$date$toTson()
        m$teamId = tson.scalar(self$teamId)
        m$projectId = tson.scalar(self$projectId)
        m$userId = tson.scalar(self$userId)
        m$projectName = tson.scalar(self$projectName)
        m$isPublic = tson.scalar(self$isPublic)
        m$properties = lapply(self$properties, function(each) each$toTson())
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
