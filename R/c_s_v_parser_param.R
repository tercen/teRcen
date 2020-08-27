#' CSVParserParam
#'
#' @export
#' @format \code{\link{R6Class}} object.
#' @field separator of type String.
#' @field encoding of type String.
#' @field quote of type String.
#' @field hasHeaders of type bool.
#' @field allowMalformed of type bool.
#' @field comment of type String.
CSVParserParam <- R6::R6Class("CSVParserParam", inherit = Base, public = list(separator = NULL, 
    encoding = NULL, quote = NULL, hasHeaders = NULL, allowMalformed = NULL, comment = NULL, 
    initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$separator = ""
        self$encoding = ""
        self$quote = ""
        self$hasHeaders = TRUE
        self$allowMalformed = TRUE
        self$comment = ""
    }, initJson = function(json) {
        super$initJson(json)
        self$separator = json$separator
        self$encoding = json$encoding
        self$quote = json$quote
        self$hasHeaders = json$hasHeaders
        self$allowMalformed = json$allowMalformed
        self$comment = json$comment
    }, toTson = function() {
        m = super$toTson()
        m$kind = tson.scalar("CSVParserParam")
        m$separator = tson.scalar(self$separator)
        m$encoding = tson.scalar(self$encoding)
        m$quote = tson.scalar(self$quote)
        m$hasHeaders = tson.scalar(self$hasHeaders)
        m$allowMalformed = tson.scalar(self$allowMalformed)
        m$comment = tson.scalar(self$comment)
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
