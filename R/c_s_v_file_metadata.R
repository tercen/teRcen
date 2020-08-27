#' CSVFileMetadata
#'
#' @export
#' @format \code{\link{R6Class}} object, super class \code{\link{FileMetadata}}.
#' @field contentType of type String inherited from super class \code{\link{FileMetadata}}.
#' @field cacheControl of type String inherited from super class \code{\link{FileMetadata}}.
#' @field contentEncoding of type String inherited from super class \code{\link{FileMetadata}}.
#' @field contentLanguage of type String inherited from super class \code{\link{FileMetadata}}.
#' @field md5Hash of type String inherited from super class \code{\link{FileMetadata}}.
#' @field separator of type String.
#' @field quote of type String.
#' @field headers of type bool.
CSVFileMetadata <- R6::R6Class("CSVFileMetadata", inherit = FileMetadata, public = list(separator = NULL, 
    quote = NULL, headers = NULL, initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$separator = ""
        self$quote = ""
        self$headers = TRUE
    }, initJson = function(json) {
        super$initJson(json)
        self$separator = json$separator
        self$quote = json$quote
        self$headers = json$headers
    }, toTson = function() {
        m = super$toTson()
        m$kind = tson.scalar("CSVFileMetadata")
        m$separator = tson.scalar(self$separator)
        m$quote = tson.scalar(self$quote)
        m$headers = tson.scalar(self$headers)
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
