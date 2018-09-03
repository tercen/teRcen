#' ColumnSchema
#'
#' @export
#' @format \code{\link{R6Class}} object, super class \code{\link{IdObject}}, sub classes \code{\link{Column}}.
#' @field id of type String inherited from super class \code{\link{IdObject}}.
#' @field name of type String.
#' @field type of type String.
#' @field nRows of type int.
#' @field size of type int.
#' @field metaData object of class \code{\link{ColumnSchemaMetaData}}.
ColumnSchema <- R6::R6Class("ColumnSchema", inherit = IdObject, public = list(name = NULL, 
    type = NULL, nRows = NULL, size = NULL, metaData = NULL, initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$name = ""
        self$type = ""
        self$nRows = 0
        self$size = 0
        self$metaData = ColumnSchemaMetaData$new()
    }, initJson = function(json) {
        super$initJson(json)
        self$name = json$name
        self$type = json$type
        self$nRows = json$nRows
        self$size = json$size
        self$metaData = createObjectFromJson(json$metaData)
    }, toTson = function() {
        m = super$toTson()
        m$kind = rtson::tson.scalar("ColumnSchema")
        m$name = rtson::tson.scalar(self$name)
        m$type = rtson::tson.scalar(self$type)
        m$nRows = rtson::tson.int(self$nRows)
        m$size = rtson::tson.int(self$size)
        if (!is.null(self$metaData)) m$metaData = self$metaData$toTson()
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
