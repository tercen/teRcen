#' TableProfile
#'
#' @export
#' @format \code{\link{R6Class}} object, super class \code{\link{Profile}}.
#' @field name of type String inherited from super class \code{\link{Profile}}.
#' @field nRows of type int.
#' @field nCols of type int.
TableProfile <- R6::R6Class("TableProfile", inherit = Profile, public = list(nRows = NULL, 
    nCols = NULL, initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$nRows = 0
        self$nCols = 0
    }, initJson = function(json) {
        super$initJson(json)
        self$nRows = json$nRows
        self$nCols = json$nCols
    }, toTson = function() {
        m = super$toTson()
        m$kind = tson.scalar("TableProfile")
        m$nRows = tson.int(self$nRows)
        m$nCols = tson.int(self$nCols)
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
