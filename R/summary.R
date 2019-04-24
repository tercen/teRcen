#' Summary
#'
#' @export
#' @format \code{\link{R6Class}} object.
#' @field tableSummary object of class \code{\link{TableSummary}}.
#' @field computedTableSummary object of class \code{\link{TableSummary}}.
#' @field queryTableSummary object of class \code{\link{TableSummary}}.
#' @field taskSummary object of class \code{\link{TaskSummary}}.
Summary <- R6::R6Class("Summary", inherit = Base, public = list(tableSummary = NULL, 
    computedTableSummary = NULL, queryTableSummary = NULL, taskSummary = NULL, initialize = function(json = NULL) {
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
        self$taskSummary = TaskSummary$new()
    }, initJson = function(json) {
        super$initJson(json)
        self$tableSummary = createObjectFromJson(json$tableSummary)
        self$computedTableSummary = createObjectFromJson(json$computedTableSummary)
        self$queryTableSummary = createObjectFromJson(json$queryTableSummary)
        self$taskSummary = createObjectFromJson(json$taskSummary)
    }, toTson = function() {
        m = super$toTson()
        m$kind = tson.scalar("Summary")
        if (!is.null(self$tableSummary)) m$tableSummary = self$tableSummary$toTson()
        if (!is.null(self$computedTableSummary)) m$computedTableSummary = self$computedTableSummary$toTson()
        if (!is.null(self$queryTableSummary)) m$queryTableSummary = self$queryTableSummary$toTson()
        if (!is.null(self$taskSummary)) m$taskSummary = self$taskSummary$toTson()
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
