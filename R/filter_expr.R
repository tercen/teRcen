#' FilterExpr
#'
#' @export
#' @format \code{\link{R6Class}} object, super class \code{\link{FilterTopExpr}}.
#' @field filterOp of type String.
#' @field stringValue of type String.
#' @field factor object of class \code{\link{Factor}}.
FilterExpr <- R6::R6Class("FilterExpr", inherit = FilterTopExpr, public = list(filterOp = NULL, 
    stringValue = NULL, factor = NULL, initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$filterOp = ""
        self$stringValue = ""
        self$factor = Factor$new()
    }, initJson = function(json) {
        super$initJson(json)
        self$filterOp = json$filterOp
        self$stringValue = json$stringValue
        self$factor = createObjectFromJson(json$factor)
    }, toTson = function() {
        m = super$toTson()
        m$kind = rtson::tson.scalar("FilterExpr")
        m$filterOp = rtson::tson.scalar(self$filterOp)
        m$stringValue = rtson::tson.scalar(self$stringValue)
        m$factor = self$factor$toTson()
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
