#' JoinMeltOperator
#'
#' @export
#' @format \code{\link{R6Class}} object, super class \code{\link{JoinOperator}}.
#' @field rightRelationId of type String.
#' @field names list of type String.
#' @field valueName of type String.
#' @field variableName of type String.
#' @field valueType of type String.
JoinMeltOperator <- R6::R6Class("JoinMeltOperator", inherit = JoinOperator, public = list(rightRelationId = NULL, 
    names = NULL, valueName = NULL, variableName = NULL, valueType = NULL, initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$rightRelationId = ""
        self$names = list()
        self$valueName = ""
        self$variableName = ""
        self$valueType = ""
    }, initJson = function(json) {
        super$initJson(json)
        self$rightRelationId = json$rightRelationId
        self$names = json$names
        self$valueName = json$valueName
        self$variableName = json$variableName
        self$valueType = json$valueType
    }, toTson = function() {
        m = super$toTson()
        m$kind = rtson::tson.scalar(jsonlite::unbox("JoinMeltOperator"))
        m$rightRelationId = rtson::tson.scalar(jsonlite::unbox(self$rightRelationId))
        m$names = lapply(self$names, function(each) rtson::tson.scalar(jsonlite::unbox(each)))
        m$valueName = rtson::tson.scalar(jsonlite::unbox(self$valueName))
        m$variableName = rtson::tson.scalar(jsonlite::unbox(self$variableName))
        m$valueType = rtson::tson.scalar(jsonlite::unbox(self$valueType))
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
