#' GatherRelation
#'
#' @export
#' @format \code{\link{R6Class}} object, super class \code{\link{Relation}}.
#' @field id of type String inherited from super class \code{\link{IdObject}}.
#' @field names list of type String.
#' @field valueName of type String.
#' @field variableName of type String.
#' @field valueType of type String.
#' @field relation object of class \code{\link{Relation}}.
GatherRelation <- R6::R6Class("GatherRelation", inherit = Relation, public = list(relation = NULL, 
    names = NULL, valueName = NULL, variableName = NULL, valueType = NULL, initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$names = list()
        self$valueName = ""
        self$variableName = ""
        self$valueType = ""
        self$relation = Relation$new()
    }, initJson = function(json) {
        super$initJson(json)
        self$names = json$names
        self$valueName = json$valueName
        self$variableName = json$variableName
        self$valueType = json$valueType
        self$relation = createObjectFromJson(json$relation)
    }, toTson = function() {
        m = super$toTson()
        m$kind = rtson::tson.scalar("GatherRelation")
        if (!is.null(self$relation)) m$relation = self$relation$toTson()
        m$names = lapply(self$names, function(each) rtson::tson.scalar(each))
        m$valueName = rtson::tson.scalar(self$valueName)
        m$variableName = rtson::tson.scalar(self$variableName)
        m$valueType = rtson::tson.scalar(self$valueType)
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
