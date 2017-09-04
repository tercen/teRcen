#' TableSchema
#'
#' @export
#' @format \code{\link{R6Class}} object, super class \code{\link{ProjectDocument}}, sub classes \code{\link{CubeQueryTableSchema}}, \code{\link{ComputedTableSchema}}.
#' @field projectId of type String inherited from super class \code{\link{ProjectDocument}}.
#' @field description of type String inherited from super class \code{\link{Document}}.
#' @field name of type String inherited from super class \code{\link{Document}}.
#' @field tags list of type String inherited from super class \code{\link{Document}}.
#' @field isDeleted of type bool inherited from super class \code{\link{PersistentObject}}.
#' @field rev of type String inherited from super class \code{\link{PersistentObject}}.
#' @field id of type String inherited from super class \code{\link{IdObject}}.
#' @field nRows of type int.
#' @field dataDirectory of type String.
#' @field acl object of class \code{\link{Acl}} inherited from super class \code{\link{Document}}.
#' @field createdDate object of class \code{\link{Date}} inherited from super class \code{\link{Document}}.
#' @field lastModifiedDate object of class \code{\link{Date}} inherited from super class \code{\link{Document}}.
#' @field urls list of class \code{\link{Url}} inherited from super class \code{\link{Document}}.
#' @field columns list of class \code{\link{ColumnSchema}}.
TableSchema <- R6::R6Class("TableSchema", inherit = ProjectDocument, public = list(nRows = NULL, 
    columns = NULL, dataDirectory = NULL, initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$nRows = 0
        self$dataDirectory = ""
        self$columns = list()
    }, initJson = function(json) {
        super$initJson(json)
        self$nRows = json$nRows
        self$dataDirectory = json$dataDirectory
        self$columns = lapply(json$columns, createObjectFromJson)
    }, toTson = function() {
        m = super$toTson()
        m$kind = rtson::tson.scalar(jsonlite::unbox("TableSchema"))
        m$nRows = rtson::tson.int(jsonlite::unbox(self$nRows))
        m$columns = lapply(self$columns, function(each) each$toTson())
        m$dataDirectory = rtson::tson.scalar(jsonlite::unbox(self$dataDirectory))
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
