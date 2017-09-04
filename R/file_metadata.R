#' FileMetadata
#'
#' @export
#' @format \code{\link{R6Class}} object, sub classes \code{\link{CSVFileMetadata}}.
#' @field contentType of type String.
#' @field cacheControl of type String.
#' @field contentEncoding of type String.
#' @field contentLanguage of type String.
#' @field md5Hash of type String.
FileMetadata <- R6::R6Class("FileMetadata", inherit = Base, public = list(contentType = NULL, 
    cacheControl = NULL, contentEncoding = NULL, contentLanguage = NULL, md5Hash = NULL, 
    initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$contentType = ""
        self$cacheControl = ""
        self$contentEncoding = ""
        self$contentLanguage = ""
        self$md5Hash = ""
    }, initJson = function(json) {
        super$initJson(json)
        self$contentType = json$contentType
        self$cacheControl = json$cacheControl
        self$contentEncoding = json$contentEncoding
        self$contentLanguage = json$contentLanguage
        self$md5Hash = json$md5Hash
    }, toTson = function() {
        m = super$toTson()
        m$kind = rtson::tson.scalar(jsonlite::unbox("FileMetadata"))
        m$contentType = rtson::tson.scalar(jsonlite::unbox(self$contentType))
        m$cacheControl = rtson::tson.scalar(jsonlite::unbox(self$cacheControl))
        m$contentEncoding = rtson::tson.scalar(jsonlite::unbox(self$contentEncoding))
        m$contentLanguage = rtson::tson.scalar(jsonlite::unbox(self$contentLanguage))
        m$md5Hash = rtson::tson.scalar(jsonlite::unbox(self$md5Hash))
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
