#' Link
#'
#' @export
#' @format \code{\link{R6Class}} object, super class \code{\link{IdObject}}.
#' @field id of type String inherited from super class \code{\link{IdObject}}.
#' @field inputId of type String.
#' @field outputId of type String.
Link <- R6::R6Class("Link", inherit = IdObject, public = list(inputId = NULL, outputId = NULL, 
    initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$inputId = ""
        self$outputId = ""
    }, initJson = function(json) {
        super$initJson(json)
        self$inputId = json$inputId
        self$outputId = json$outputId
    }, toTson = function() {
        m = super$toTson()
        m$kind = tson.scalar("Link")
        m$inputId = tson.scalar(self$inputId)
        m$outputId = tson.scalar(self$outputId)
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
