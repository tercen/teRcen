#' ColumnSchemaMetaData
#'
#' @export
#' @format \code{\link{R6Class}} object.
#' @field quartiles list of type String.
ColumnSchemaMetaData <- R6::R6Class("ColumnSchemaMetaData", inherit = Base, public = list(quartiles = NULL, 
    initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$quartiles = list()
    }, initJson = function(json) {
        super$initJson(json)
        self$quartiles = json$quartiles
    }, toTson = function() {
        m = super$toTson()
        m$kind = rtson::tson.scalar("ColumnSchemaMetaData")
        m$quartiles = lapply(self$quartiles, function(each) rtson::tson.scalar(each))
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
