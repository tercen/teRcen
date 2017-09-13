#' StorageProfile
#'
#' @export
#' @format \code{\link{R6Class}} object.
#' @field name of type String.
#' @field size of type int.
StorageProfile <- R6::R6Class("StorageProfile", inherit = Base, public = list(name = NULL, 
    size = NULL, initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$name = ""
        self$size = 0
    }, initJson = function(json) {
        super$initJson(json)
        self$name = json$name
        self$size = json$size
    }, toTson = function() {
        m = super$toTson()
        m$kind = rtson::tson.scalar("StorageProfile")
        m$name = rtson::tson.scalar(self$name)
        m$size = rtson::tson.int(self$size)
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
