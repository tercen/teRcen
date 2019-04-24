#' DataStep
#'
#' @export
#' @format \code{\link{R6Class}} object, super class \code{\link{CrossTabStep}}.
#' @field groupId of type String inherited from super class \code{\link{Step}}.
#' @field name of type String inherited from super class \code{\link{Step}}.
#' @field id of type String inherited from super class \code{\link{IdObject}}.
#' @field model object of class \code{\link{Crosstab}} inherited from super class \code{\link{CrossTabStep}}.
#' @field inputs list of class \code{\link{InputPort}} inherited from super class \code{\link{Step}}.
#' @field outputs list of class \code{\link{OutputPort}} inherited from super class \code{\link{Step}}.
#' @field rectangle object of class \code{\link{Rectangle}} inherited from super class \code{\link{Step}}.
#' @field state object of class \code{\link{StepState}} inherited from super class \code{\link{Step}}.
#' @field computedRelation object of class \code{\link{Relation}}.
DataStep <- R6::R6Class("DataStep", inherit = CrossTabStep, public = list(computedRelation = NULL, 
    initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$computedRelation = Relation$new()
    }, initJson = function(json) {
        super$initJson(json)
        self$computedRelation = createObjectFromJson(json$computedRelation)
    }, toTson = function() {
        m = super$toTson()
        m$kind = tson.scalar("DataStep")
        if (!is.null(self$computedRelation)) m$computedRelation = self$computedRelation$toTson()
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
