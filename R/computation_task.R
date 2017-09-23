#' ComputationTask
#'
#' @export
#' @format \code{\link{R6Class}} object, super class \code{\link{CubeQueryTask}}.
#' @field duration of type double inherited from super class \code{\link{Task}}.
#' @field owner of type String inherited from super class \code{\link{Task}}.
#' @field projectId of type String inherited from super class \code{\link{Task}}.
#' @field taskHash of type String inherited from super class \code{\link{Task}}.
#' @field runProfile of type String inherited from super class \code{\link{Task}}.
#' @field isDeleted of type bool inherited from super class \code{\link{PersistentObject}}.
#' @field rev of type String inherited from super class \code{\link{PersistentObject}}.
#' @field id of type String inherited from super class \code{\link{IdObject}}.
#' @field removeOnGC of type bool.
#' @field fileResultId of type String.
#' @field query object of class \code{\link{CubeQuery}} inherited from super class \code{\link{CubeQueryTask}}.
#' @field state object of class \code{\link{State}} inherited from super class \code{\link{Task}}.
#' @field createdDate object of class \code{\link{Date}} inherited from super class \code{\link{Task}}.
#' @field lastModifiedDate object of class \code{\link{Date}} inherited from super class \code{\link{Task}}.
#' @field runDate object of class \code{\link{Date}} inherited from super class \code{\link{Task}}.
#' @field completedDate object of class \code{\link{Date}} inherited from super class \code{\link{Task}}.
#' @field aclContext object of class \code{\link{AclContext}} inherited from super class \code{\link{Task}}.
#' @field result list of class \code{\link{JoinOperator}}.
ComputationTask <- R6::R6Class("ComputationTask", inherit = CubeQueryTask, public = list(removeOnGC = NULL, 
    fileResultId = NULL, result = NULL, initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$removeOnGC = TRUE
        self$fileResultId = ""
        self$result = list()
    }, initJson = function(json) {
        super$initJson(json)
        self$removeOnGC = json$removeOnGC
        self$fileResultId = json$fileResultId
        self$result = lapply(json$result, createObjectFromJson)
    }, toTson = function() {
        m = super$toTson()
        m$kind = rtson::tson.scalar("ComputationTask")
        m$removeOnGC = rtson::tson.scalar(self$removeOnGC)
        m$fileResultId = rtson::tson.scalar(self$fileResultId)
        m$result = lapply(self$result, function(each) each$toTson())
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
