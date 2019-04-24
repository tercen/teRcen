#' StorageProfile
#'
#' @export
#' @format \code{\link{R6Class}} object, super class \code{\link{Profile}}.
#' @field name of type String inherited from super class \code{\link{Profile}}.
#' @field size of type int.
StorageProfile <- R6::R6Class("StorageProfile", inherit = Profile, public = list(size = NULL, 
    initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$size = 0
    }, initJson = function(json) {
        super$initJson(json)
        self$size = json$size
    }, toTson = function() {
        m = super$toTson()
        m$kind = tson.scalar("StorageProfile")
        m$size = tson.int(self$size)
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
