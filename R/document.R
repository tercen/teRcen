#' Document
#'
#' @export
#' @format \code{\link{R6Class}} object, super class \code{\link{PersistentObject}}, sub classes \code{\link{Team}}, \code{\link{CubeQueryTableSchema}}, \code{\link{TableSchema}}, \code{\link{ComputedTableSchema}}, \code{\link{RSourceOperator}}, \code{\link{SourceOperator}}, \code{\link{ExternalOperator}}, \code{\link{Schema}}, \code{\link{Operator}}, \code{\link{FileDocument}}, \code{\link{Workflow}}, \code{\link{User}}, \code{\link{ProjectDocument}}, \code{\link{Project}}.
#' @field isDeleted of type bool inherited from super class \code{\link{PersistentObject}}.
#' @field rev of type String inherited from super class \code{\link{PersistentObject}}.
#' @field id of type String inherited from super class \code{\link{IdObject}}.
#' @field description of type String.
#' @field name of type String.
#' @field createdBy of type String.
#' @field tags list of type String.
#' @field acl object of class \code{\link{Acl}}.
#' @field createdDate object of class \code{\link{Date}}.
#' @field lastModifiedDate object of class \code{\link{Date}}.
#' @field urls list of class \code{\link{Url}}.
Document <- R6::R6Class("Document", inherit = PersistentObject, public = list(description = NULL, 
    name = NULL, createdBy = NULL, tags = NULL, acl = NULL, createdDate = NULL, lastModifiedDate = NULL, 
    urls = NULL, initialize = function(json = NULL) {
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
        self$acl = Acl$new()
        self$createdDate = Date$new()
        self$lastModifiedDate = Date$new()
        self$urls = list()
    }, initJson = function(json) {
        super$initJson(json)
        self$description = json$description
        self$name = json$name
        self$createdBy = json$createdBy
        self$tags = json$tags
        self$acl = createObjectFromJson(json$acl)
        self$createdDate = createObjectFromJson(json$createdDate)
        self$lastModifiedDate = createObjectFromJson(json$lastModifiedDate)
        self$urls = lapply(json$urls, createObjectFromJson)
    }, toTson = function() {
        m = super$toTson()
        m$kind = rtson::tson.scalar("Document")
        m$description = rtson::tson.scalar(self$description)
        m$name = rtson::tson.scalar(self$name)
        m$createdBy = rtson::tson.scalar(self$createdBy)
        m$tags = lapply(self$tags, function(each) rtson::tson.scalar(each))
        m$acl = self$acl$toTson()
        m$createdDate = self$createdDate$toTson()
        m$lastModifiedDate = self$lastModifiedDate$toTson()
        m$urls = lapply(self$urls, function(each) each$toTson())
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
