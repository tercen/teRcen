#' IssueMessageService
#'
#' @export
#' @format \code{\link{R6Class}} object.
#' @section Methods:
#' \describe{
#' }
#' 
IssueMessageService <- R6::R6Class("IssueMessageService", inherit = HttpClientService, 
    public = list(initialize = function(baseRestUri, client) {
        super$initialize(baseRestUri, client)
        self$uri = "api/v1/issue_message"
    }, findByIssueAndLastModifiedDate = function(startKey = NULL, endKey = NULL, 
        limit = 20, skip = 0, descending = TRUE, useFactory = FALSE) {
        return(self$findStartKeys("findByIssueAndLastModifiedDate", startKey = startKey, 
            endKey = endKey, limit = limit, skip = skip, descending = descending, 
            useFactory = useFactory))
    }))
