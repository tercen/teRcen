#' IssueService
#'
#' @export
#' @format \code{\link{R6Class}} object.
#' @section Methods:
#' \describe{
#' }
#' 
IssueService <- R6::R6Class("IssueService", inherit = HttpClientService, public = list(initialize = function(baseRestUri, 
    client) {
    super$initialize(baseRestUri, client)
    self$uri = "api/v1/issue"
}, findByProjectAndLastModifiedDate = function(startKey = NULL, endKey = NULL, limit = 20, 
    skip = 0, descending = TRUE, useFactory = FALSE) {
    return(self$findStartKeys("findByProjectAndLastModifiedDate", startKey = startKey, 
        endKey = endKey, limit = limit, skip = skip, descending = descending, useFactory = useFactory))
}))
