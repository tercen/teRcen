#' Version
#'
#' @export
#' @format \code{\link{R6Class}} object.
#' @field major of type int.
#' @field minor of type int.
#' @field patch of type int.
#' @field tag of type String.
#' @field date of type String.
#' @field commit of type String.
Version <- R6::R6Class("Version", inherit = Base, public = list(major = NULL, minor = NULL, 
    patch = NULL, tag = NULL, date = NULL, commit = NULL, initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$major = 0
        self$minor = 0
        self$patch = 0
        self$tag = ""
        self$date = ""
        self$commit = ""
    }, initJson = function(json) {
        super$initJson(json)
        self$major = json$major
        self$minor = json$minor
        self$patch = json$patch
        self$tag = json$tag
        self$date = json$date
        self$commit = json$commit
    }, toTson = function() {
        m = super$toTson()
        m$kind = tson.scalar("Version")
        m$major = tson.int(self$major)
        m$minor = tson.int(self$minor)
        m$patch = tson.int(self$patch)
        m$tag = tson.scalar(self$tag)
        m$date = tson.scalar(self$date)
        m$commit = tson.scalar(self$commit)
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
