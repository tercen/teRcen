#' RDescription
#'
#' @export
#' @format \code{\link{R6Class}} object.
#' @field Package of type String.
#' @field Version of type String.
#' @field Depends of type String.
#' @field Imports of type String.
#' @field LinkingTo of type String.
#' @field Suggests of type String.
#' @field License of type String.
#' @field MD5sum of type String.
#' @field NeedsCompilation of type String.
RDescription <- R6::R6Class("RDescription", inherit = Base, public = list(Package = NULL, 
    Version = NULL, Depends = NULL, Imports = NULL, LinkingTo = NULL, Suggests = NULL, 
    License = NULL, MD5sum = NULL, NeedsCompilation = NULL, initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$Package = ""
        self$Version = ""
        self$Depends = ""
        self$Imports = ""
        self$LinkingTo = ""
        self$Suggests = ""
        self$License = ""
        self$MD5sum = ""
        self$NeedsCompilation = ""
    }, initJson = function(json) {
        super$initJson(json)
        self$Package = json$Package
        self$Version = json$Version
        self$Depends = json$Depends
        self$Imports = json$Imports
        self$LinkingTo = json$LinkingTo
        self$Suggests = json$Suggests
        self$License = json$License
        self$MD5sum = json$MD5sum
        self$NeedsCompilation = json$NeedsCompilation
    }, toTson = function() {
        m = super$toTson()
        m$kind = tson.scalar("RDescription")
        m$Package = tson.scalar(self$Package)
        m$Version = tson.scalar(self$Version)
        m$Depends = tson.scalar(self$Depends)
        m$Imports = tson.scalar(self$Imports)
        m$LinkingTo = tson.scalar(self$LinkingTo)
        m$Suggests = tson.scalar(self$Suggests)
        m$License = tson.scalar(self$License)
        m$MD5sum = tson.scalar(self$MD5sum)
        m$NeedsCompilation = tson.scalar(self$NeedsCompilation)
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
