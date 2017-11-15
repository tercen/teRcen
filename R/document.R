#' Document
#'
#' @export
#' @format \code{\link{R6Class}} object, super class \code{\link{PersistentObject}}, sub classes \code{\link{Team}}, \code{\link{ShinyOperator}}, \code{\link{ROperator}}, \code{\link{WebAppOperator}}, \code{\link{GitOperator}}, \code{\link{CubeQueryTableSchema}}, \code{\link{TableSchema}}, \code{\link{ComputedTableSchema}}, \code{\link{Schema}}, \code{\link{FileDocument}}, \code{\link{Workflow}}, \code{\link{User}}, \code{\link{Operator}}, \code{\link{ProjectDocument}}, \code{\link{Project}}.
#' @field isDeleted of type bool inherited from super class \code{\link{PersistentObject}}.
#' @field rev of type String inherited from super class \code{\link{PersistentObject}}.
#' @field id of type String inherited from super class \code{\link{IdObject}}.
#' @field description of type String.
#' @field name of type String.
#' @field createdBy of type String.
#' @field tags list of type String.
#' @field version of type String.
#' @field authors list of type String.
#' @field acl object of class \code{\link{Acl}}.
#' @field createdDate object of class \code{\link{Date}}.
#' @field lastModifiedDate object of class \code{\link{Date}}.
#' @field urls list of class \code{\link{Url}}.
#' @field meta list of class \code{\link{Pair}}.
#' @field url object of class \code{\link{Url}}.
Document <- R6::R6Class("Document", inherit = PersistentObject, public = list(description = NULL, 
    name = NULL, createdBy = NULL, acl = NULL, createdDate = NULL, lastModifiedDate = NULL, 
    urls = NULL, tags = NULL, meta = NULL, url = NULL, version = NULL, authors = NULL, 
    initialize = function(json = NULL) {
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
        self$acl = createObjectFromJson(json$acl)
        self$createdDate = createObjectFromJson(json$createdDate)
        self$lastModifiedDate = createObjectFromJson(json$lastModifiedDate)
        self$urls = lapply(json$urls, createObjectFromJson)
        self$meta = lapply(json$meta, createObjectFromJson)
        self$url = createObjectFromJson(json$url)
    }, toTson = function() {
        m = super$toTson()
        m$kind = rtson::tson.scalar("Document")
        m$description = rtson::tson.scalar(self$description)
        m$name = rtson::tson.scalar(self$name)
        m$createdBy = rtson::tson.scalar(self$createdBy)
        m$acl = self$acl$toTson()
        m$createdDate = self$createdDate$toTson()
        m$lastModifiedDate = self$lastModifiedDate$toTson()
        m$urls = lapply(self$urls, function(each) each$toTson())
        m$tags = lapply(self$tags, function(each) rtson::tson.scalar(each))
        m$meta = lapply(self$meta, function(each) each$toTson())
        m$url = self$url$toTson()
        m$version = rtson::tson.scalar(self$version)
        m$authors = lapply(self$authors, function(each) rtson::tson.scalar(each))
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
