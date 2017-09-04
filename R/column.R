#' Column
#'
#' @export
#' @format \code{\link{R6Class}} object, super class \code{\link{ColumnSchema}}.
#' @field name of type String inherited from super class \code{\link{ColumnSchema}}.
#' @field type of type String inherited from super class \code{\link{ColumnSchema}}.
#' @field nRows of type int inherited from super class \code{\link{ColumnSchema}}.
#' @field id of type String inherited from super class \code{\link{IdObject}}.
#' @field values of type dynamic.
#' @field metaData object of class \code{\link{ColumnSchemaMetaData}} inherited from super class \code{\link{ColumnSchema}}.
Column <- R6::R6Class("Column", inherit = ColumnSchema, public = list(values = NULL, 
    initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$values = NULL
    }, initJson = function(json) {
        super$initJson(json)
        self$values = json$values
    }, toTson = function() {
        m = super$toTson()
        m$kind = rtson::tson.scalar(jsonlite::unbox("Column"))
        m$values = self$values
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
