#' ColumnSchemaMetaData
#'
#' @export
#' @format \code{\link{R6Class}} object.
#' @field sort list of type String.
#' @field ascending of type bool.
#' @field quartiles list of type String.
ColumnSchemaMetaData <- R6::R6Class("ColumnSchemaMetaData", inherit = Base, public = list(sort = NULL, 
    ascending = NULL, quartiles = NULL, initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$sort = list()
        self$ascending = TRUE
        self$quartiles = list()
    }, initJson = function(json) {
        super$initJson(json)
        self$sort = json$sort
        self$ascending = json$ascending
        self$quartiles = json$quartiles
    }, toTson = function() {
        m = super$toTson()
        m$kind = rtson::tson.scalar("ColumnSchemaMetaData")
        m$sort = lapply(self$sort, function(each) rtson::tson.scalar(each))
        m$ascending = rtson::tson.scalar(self$ascending)
        m$quartiles = lapply(self$quartiles, function(each) rtson::tson.scalar(each))
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
