#' StorageSummary
#'
#' @export
#' @format \code{\link{R6Class}} object.
#' @field tableSummary object of class \code{\link{TableSummary}}.
#' @field computedTableSummary object of class \code{\link{TableSummary}}.
#' @field queryTableSummary object of class \code{\link{TableSummary}}.
StorageSummary <- R6::R6Class("StorageSummary", inherit = Base, public = list(tableSummary = NULL, 
    computedTableSummary = NULL, queryTableSummary = NULL, initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$tableSummary = TableSummary$new()
        self$computedTableSummary = TableSummary$new()
        self$queryTableSummary = TableSummary$new()
    }, initJson = function(json) {
        super$initJson(json)
        self$tableSummary = createObjectFromJson(json$tableSummary)
        self$computedTableSummary = createObjectFromJson(json$computedTableSummary)
        self$queryTableSummary = createObjectFromJson(json$queryTableSummary)
    }, toTson = function() {
        m = super$toTson()
        m$kind = rtson::tson.scalar("StorageSummary")
        m$tableSummary = self$tableSummary$toTson()
        m$computedTableSummary = self$computedTableSummary$toTson()
        m$queryTableSummary = self$queryTableSummary$toTson()
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
