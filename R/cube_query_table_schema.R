#' CubeQueryTableSchema
#'
#' @export
#' @format \code{\link{R6Class}} object, super class \code{\link{Schema}}.
#' @field nRows of type int inherited from super class \code{\link{Schema}}.
#' @field dataDirectory of type String inherited from super class \code{\link{Schema}}.
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
#' @field queryHash of type String.
#' @field columns list of class \code{\link{ColumnSchema}} inherited from super class \code{\link{Schema}}.
#' @field acl object of class \code{\link{Acl}} inherited from super class \code{\link{Document}}.
#' @field createdDate object of class \code{\link{Date}} inherited from super class \code{\link{Document}}.
#' @field lastModifiedDate object of class \code{\link{Date}} inherited from super class \code{\link{Document}}.
#' @field urls list of class \code{\link{Url}} inherited from super class \code{\link{Document}}.
#' @field meta list of class \code{\link{Pair}} inherited from super class \code{\link{Document}}.
#' @field url object of class \code{\link{Url}} inherited from super class \code{\link{Document}}.
CubeQueryTableSchema <- R6::R6Class("CubeQueryTableSchema", inherit = Schema, public = list(queryHash = NULL, 
    initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$queryHash = ""
    }, initJson = function(json) {
        super$initJson(json)
        self$queryHash = json$queryHash
    }, toTson = function() {
        m = super$toTson()
        m$kind = rtson::tson.scalar("CubeQueryTableSchema")
        m$queryHash = rtson::tson.scalar(self$queryHash)
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
