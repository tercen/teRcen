#' GitOperator
#'
#' @export
#' @format \code{\link{R6Class}} object, super class \code{\link{Operator}}, sub classes \code{\link{ShinyOperator}}, \code{\link{ROperator}}, \code{\link{WebAppOperator}}.
#' @field projectId of type String inherited from super class \code{\link{ProjectDocument}}.
#' @field description of type String inherited from super class \code{\link{Document}}.
#' @field name of type String inherited from super class \code{\link{Document}}.
#' @field createdBy of type String inherited from super class \code{\link{Document}}.
#' @field tags list of type String inherited from super class \code{\link{Document}}.
#' @field isDeleted of type bool inherited from super class \code{\link{PersistentObject}}.
#' @field rev of type String inherited from super class \code{\link{PersistentObject}}.
#' @field id of type String inherited from super class \code{\link{IdObject}}.
#' @field path of type String.
#' @field version of type String.
#' @field properties list of class \code{\link{Property}} inherited from super class \code{\link{Operator}}.
#' @field acl object of class \code{\link{Acl}} inherited from super class \code{\link{Document}}.
#' @field createdDate object of class \code{\link{Date}} inherited from super class \code{\link{Document}}.
#' @field lastModifiedDate object of class \code{\link{Date}} inherited from super class \code{\link{Document}}.
#' @field urls list of class \code{\link{Url}} inherited from super class \code{\link{Document}}.
#' @field url object of class \code{\link{Url}}.
GitOperator <- R6::R6Class("GitOperator", inherit = Operator, public = list(url = NULL, 
    path = NULL, version = NULL, initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$path = ""
        self$version = ""
        self$url = Url$new()
    }, initJson = function(json) {
        super$initJson(json)
        self$path = json$path
        self$version = json$version
        self$url = createObjectFromJson(json$url)
    }, toTson = function() {
        m = super$toTson()
        m$kind = rtson::tson.scalar("GitOperator")
        m$url = self$url$toTson()
        m$path = rtson::tson.scalar(self$path)
        m$version = rtson::tson.scalar(self$version)
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
