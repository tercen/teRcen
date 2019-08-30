#' WebAppOperator
#'
#' @export
#' @format \code{\link{R6Class}} object, super class \code{\link{GitOperator}}, sub classes \code{\link{ShinyOperator}}.
#' @field path of type String inherited from super class \code{\link{GitOperator}}.
#' @field description of type String inherited from super class \code{\link{Document}}.
#' @field name of type String inherited from super class \code{\link{Document}}.
#' @field createdBy of type String inherited from super class \code{\link{Document}}.
#' @field tags list of type String inherited from super class \code{\link{Document}}.
#' @field version of type String inherited from super class \code{\link{Document}}.
#' @field authors list of type String inherited from super class \code{\link{Document}}.
#' @field isDeleted of type bool inherited from super class \code{\link{PersistentObject}}.
#' @field rev of type String inherited from super class \code{\link{PersistentObject}}.
#' @field id of type String inherited from super class \code{\link{IdObject}}.
#' @field isViewOnly of type bool.
#' @field properties list of class \code{\link{Property}} inherited from super class \code{\link{Operator}}.
#' @field acl object of class \code{\link{Acl}} inherited from super class \code{\link{Document}}.
#' @field createdDate object of class \code{\link{Date}} inherited from super class \code{\link{Document}}.
#' @field lastModifiedDate object of class \code{\link{Date}} inherited from super class \code{\link{Document}}.
#' @field urls list of class \code{\link{Url}} inherited from super class \code{\link{Document}}.
#' @field meta list of class \code{\link{Pair}} inherited from super class \code{\link{Document}}.
#' @field url object of class \code{\link{Url}} inherited from super class \code{\link{Document}}.
WebAppOperator <- R6::R6Class("WebAppOperator", inherit = GitOperator, public = list(isViewOnly = NULL, 
    initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$isViewOnly = TRUE
    }, initJson = function(json) {
        super$initJson(json)
        self$isViewOnly = json$isViewOnly
    }, toTson = function() {
        m = super$toTson()
        m$kind = tson.scalar("WebAppOperator")
        m$isViewOnly = tson.scalar(self$isViewOnly)
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
