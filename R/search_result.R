#' SearchResult
#'
#' @export
#' @format \code{\link{R6Class}} object.
#' @field total_rows of type int.
#' @field bookmark of type String.
#' @field rows list of class \code{\link{PersistentObject}}.
SearchResult <- R6::R6Class("SearchResult", inherit = Base, public = list(total_rows = NULL, 
    bookmark = NULL, rows = NULL, initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$total_rows = 0
        self$bookmark = ""
        self$rows = list()
    }, initJson = function(json) {
        super$initJson(json)
        self$total_rows = json$total_rows
        self$bookmark = json$bookmark
        self$rows = lapply(json$rows, createObjectFromJson)
    }, toTson = function() {
        m = super$toTson()
        m$kind = tson.scalar("SearchResult")
        m$total_rows = tson.int(self$total_rows)
        m$bookmark = tson.scalar(self$bookmark)
        m$rows = lapply(self$rows, function(each) each$toTson())
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
