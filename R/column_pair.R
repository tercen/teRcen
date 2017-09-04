#' ColumnPair
#'
#' @export
#' @format \code{\link{R6Class}} object.
#' @field lColumns list of type String.
#' @field rColumns list of type String.
ColumnPair <- R6::R6Class("ColumnPair", inherit = Base, public = list(lColumns = NULL, 
    rColumns = NULL, initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$lColumns = list()
        self$rColumns = list()
    }, initJson = function(json) {
        super$initJson(json)
        self$lColumns = json$lColumns
        self$rColumns = json$rColumns
    }, toTson = function() {
        m = super$toTson()
        m$kind = rtson::tson.scalar(jsonlite::unbox("ColumnPair"))
        m$lColumns = lapply(self$lColumns, function(each) rtson::tson.scalar(jsonlite::unbox(each)))
        m$rColumns = lapply(self$rColumns, function(each) rtson::tson.scalar(jsonlite::unbox(each)))
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
