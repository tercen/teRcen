#' Worker
#'
#' @export
#' @format \code{\link{R6Class}} object.
#' @field uri of type String.
#' @field threads of type int.
Worker <- R6::R6Class("Worker", inherit = Base, public = list(uri = NULL, threads = NULL, 
    initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$uri = ""
        self$threads = 0
    }, initJson = function(json) {
        super$initJson(json)
        self$uri = json$uri
        self$threads = json$threads
    }, toTson = function() {
        m = super$toTson()
        m$kind = rtson::tson.scalar(jsonlite::unbox("Worker"))
        m$uri = rtson::tson.scalar(jsonlite::unbox(self$uri))
        m$threads = rtson::tson.int(jsonlite::unbox(self$threads))
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
