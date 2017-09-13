#' GarbageTasks
#'
#' @export
#' @format \code{\link{R6Class}} object, super class \code{\link{GarbageObject}}.
#' @field isDeleted of type bool inherited from super class \code{\link{PersistentObject}}.
#' @field rev of type String inherited from super class \code{\link{PersistentObject}}.
#' @field id of type String inherited from super class \code{\link{IdObject}}.
#' @field workflowId of type String.
#' @field deletedTaskIds list of type String.
#' @field addedTaskIds list of type String.
GarbageTasks <- R6::R6Class("GarbageTasks", inherit = GarbageObject, public = list(workflowId = NULL, 
    deletedTaskIds = NULL, addedTaskIds = NULL, initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$workflowId = ""
        self$deletedTaskIds = list()
        self$addedTaskIds = list()
    }, initJson = function(json) {
        super$initJson(json)
        self$workflowId = json$workflowId
        self$deletedTaskIds = json$deletedTaskIds
        self$addedTaskIds = json$addedTaskIds
    }, toTson = function() {
        m = super$toTson()
        m$kind = rtson::tson.scalar("GarbageTasks")
        m$workflowId = rtson::tson.scalar(self$workflowId)
        m$deletedTaskIds = lapply(self$deletedTaskIds, function(each) rtson::tson.scalar(each))
        m$addedTaskIds = lapply(self$addedTaskIds, function(each) rtson::tson.scalar(each))
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
