#' StartProcess
#'
#' @export
#' @format \code{\link{R6Class}} object, super class \code{\link{IdObject}}.
#' @field id of type String inherited from super class \code{\link{IdObject}}.
#' @field executable of type String.
#' @field arguments list of type String.
#' @field timeout of type int.
#' @field pid of type int.
#' @field script of type String.
#' @field ulimits object of class \code{\link{Ulimits}}.
StartProcess <- R6::R6Class("StartProcess", inherit = IdObject, public = list(executable = NULL, 
    arguments = NULL, ulimits = NULL, timeout = NULL, pid = NULL, script = NULL, 
    initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$executable = ""
        self$arguments = list()
        self$timeout = 0
        self$pid = 0
        self$script = ""
        self$ulimits = Ulimits$new()
    }, initJson = function(json) {
        super$initJson(json)
        self$executable = json$executable
        self$arguments = json$arguments
        self$timeout = json$timeout
        self$pid = json$pid
        self$script = json$script
        self$ulimits = createObjectFromJson(json$ulimits)
    }, toTson = function() {
        m = super$toTson()
        m$kind = tson.scalar("StartProcess")
        m$executable = tson.scalar(self$executable)
        m$arguments = lapply(self$arguments, function(each) tson.scalar(each))
        if (!is.null(self$ulimits)) m$ulimits = self$ulimits$toTson()
        m$timeout = tson.int(self$timeout)
        m$pid = tson.int(self$pid)
        m$script = tson.scalar(self$script)
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
