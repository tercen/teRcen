#' FileDocument
#'
#' @export
#' @format \code{\link{R6Class}} object, super class \code{\link{ProjectDocument}}.
#' @field projectId of type String inherited from super class \code{\link{ProjectDocument}}.
#' @field description of type String inherited from super class \code{\link{Document}}.
#' @field name of type String inherited from super class \code{\link{Document}}.
#' @field createdBy of type String inherited from super class \code{\link{Document}}.
#' @field tags list of type String inherited from super class \code{\link{Document}}.
#' @field isDeleted of type bool inherited from super class \code{\link{PersistentObject}}.
#' @field rev of type String inherited from super class \code{\link{PersistentObject}}.
#' @field id of type String inherited from super class \code{\link{IdObject}}.
#' @field dataUri of type String.
#' @field size of type int.
#' @field acl object of class \code{\link{Acl}} inherited from super class \code{\link{Document}}.
#' @field createdDate object of class \code{\link{Date}} inherited from super class \code{\link{Document}}.
#' @field lastModifiedDate object of class \code{\link{Date}} inherited from super class \code{\link{Document}}.
#' @field urls list of class \code{\link{Url}} inherited from super class \code{\link{Document}}.
#' @field metadata object of class \code{\link{FileMetadata}}.
FileDocument <- R6::R6Class("FileDocument", inherit = ProjectDocument, public = list(dataUri = NULL, 
    metadata = NULL, size = NULL, initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$dataUri = ""
        self$size = 0
        self$metadata = FileMetadata$new()
    }, initJson = function(json) {
        super$initJson(json)
        self$dataUri = json$dataUri
        self$size = json$size
        self$metadata = createObjectFromJson(json$metadata)
    }, toTson = function() {
        m = super$toTson()
        m$kind = rtson::tson.scalar("FileDocument")
        m$dataUri = rtson::tson.scalar(self$dataUri)
        m$metadata = self$metadata$toTson()
        m$size = rtson::tson.int(self$size)
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
