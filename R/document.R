#' Document
#'
#' @export
#' @format \code{\link{R6Class}} object, super class \code{\link{PersistentObject}}, sub classes \code{\link{Team}}, \code{\link{RSourceLibrary}}, \code{\link{RenvInstalledLibrary}}, \code{\link{ShinyOperator}}, \code{\link{DockerWebAppOperator}}, \code{\link{DockerOperator}}, \code{\link{ROperator}}, \code{\link{WebAppOperator}}, \code{\link{GitOperator}}, \code{\link{CubeQueryTableSchema}}, \code{\link{TableSchema}}, \code{\link{ComputedTableSchema}}, \code{\link{Issue}}, \code{\link{FileDocument}}, \code{\link{FolderDocument}}, \code{\link{Schema}}, \code{\link{IssueMessage}}, \code{\link{Workflow}}, \code{\link{User}}, \code{\link{RLibrary}}, \code{\link{Operator}}, \code{\link{WorkerEndpoint}}, \code{\link{ProjectDocument}}, \code{\link{Project}}, \code{\link{SubscriptionPlan}}.
#' @field isDeleted of type bool inherited from super class \code{\link{PersistentObject}}.
#' @field rev of type String inherited from super class \code{\link{PersistentObject}}.
#' @field id of type String inherited from super class \code{\link{IdObject}}.
#' @field description of type String.
#' @field name of type String.
#' @field createdBy of type String.
#' @field tags list of type String.
#' @field version of type String.
#' @field authors list of type String.
#' @field isPublic of type bool.
#' @field acl object of class \code{\link{Acl}}.
#' @field createdDate object of class \code{\link{Date}}.
#' @field lastModifiedDate object of class \code{\link{Date}}.
#' @field urls list of class \code{\link{Url}}.
#' @field meta list of class \code{\link{Pair}}.
#' @field url object of class \code{\link{Url}}.
Document <- R6::R6Class("Document", inherit = PersistentObject, public = list(description = NULL, 
    name = NULL, createdBy = NULL, acl = NULL, createdDate = NULL, lastModifiedDate = NULL, 
    urls = NULL, tags = NULL, meta = NULL, url = NULL, version = NULL, authors = NULL, 
    isPublic = NULL, initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$description = ""
        self$name = ""
        self$createdBy = ""
        self$tags = list()
        self$version = ""
        self$authors = list()
        self$isPublic = TRUE
        self$acl = Acl$new()
        self$createdDate = Date$new()
        self$lastModifiedDate = Date$new()
        self$urls = list()
        self$meta = list()
        self$url = Url$new()
    }, initJson = function(json) {
        super$initJson(json)
        self$description = json$description
        self$name = json$name
        self$createdBy = json$createdBy
        self$tags = json$tags
        self$version = json$version
        self$authors = json$authors
        self$isPublic = json$isPublic
        self$acl = createObjectFromJson(json$acl)
        self$createdDate = createObjectFromJson(json$createdDate)
        self$lastModifiedDate = createObjectFromJson(json$lastModifiedDate)
        self$urls = lapply(json$urls, createObjectFromJson)
        self$meta = lapply(json$meta, createObjectFromJson)
        self$url = createObjectFromJson(json$url)
    }, toTson = function() {
        m = super$toTson()
        m$kind = tson.scalar("Document")
        m$description = tson.scalar(self$description)
        m$name = tson.scalar(self$name)
        m$createdBy = tson.scalar(self$createdBy)
        if (!is.null(self$acl)) m$acl = self$acl$toTson()
        if (!is.null(self$createdDate)) m$createdDate = self$createdDate$toTson()
        if (!is.null(self$lastModifiedDate)) m$lastModifiedDate = self$lastModifiedDate$toTson()
        m$urls = lapply(self$urls, function(each) each$toTson())
        m$tags = lapply(self$tags, function(each) tson.scalar(each))
        m$meta = lapply(self$meta, function(each) each$toTson())
        if (!is.null(self$url)) m$url = self$url$toTson()
        m$version = tson.scalar(self$version)
        m$authors = lapply(self$authors, function(each) tson.scalar(each))
        m$isPublic = tson.scalar(self$isPublic)
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
