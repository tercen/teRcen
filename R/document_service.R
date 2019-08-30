#' DocumentService
#'
#' @export
#' @format \code{\link{R6Class}} object.
#' @section Methods:
#' \describe{
#'    \item{\code{getTercenOperatorLibrary(offset,limit)}}{method}
#'    \item{\code{getTercenWorkflowLibrary(offset,limit)}}{method}
#'    \item{\code{getTercenAppLibrary(offset,limit)}}{method}
#' }
#' 
DocumentService <- R6::R6Class("DocumentService", inherit = HttpClientService, public = list(initialize = function(baseRestUri, 
    client) {
    super$initialize(baseRestUri, client)
    self$uri = "api/v1/d"
}, findProjectByOwnersAndCreatedDate = function(startKey = NULL, endKey = NULL, limit = 20, 
    skip = 0, descending = TRUE, useFactory = FALSE) {
    return(self$findStartKeys("findProjectByOwnersAndCreatedDate", startKey = startKey, 
        endKey = endKey, limit = limit, skip = skip, descending = descending, useFactory = useFactory))
}, findWorkflowByTagOwnerCreatedDate = function(startKey = NULL, endKey = NULL, limit = 20, 
    skip = 0, descending = TRUE, useFactory = FALSE) {
    return(self$findStartKeys("findWorkflowByTagOwnerCreatedDate", startKey = startKey, 
        endKey = endKey, limit = limit, skip = skip, descending = descending, useFactory = useFactory))
}, findOperatorByOwnerLastModifiedDate = function(startKey = NULL, endKey = NULL, 
    limit = 20, skip = 0, descending = TRUE, useFactory = FALSE) {
    return(self$findStartKeys("findOperatorByOwnerLastModifiedDate", startKey = startKey, 
        endKey = endKey, limit = limit, skip = skip, descending = descending, useFactory = useFactory))
}, getTercenOperatorLibrary = function(offset, limit) {
    answer = NULL
    response = NULL
    uri = paste0("api/v1/d", "/", "getTercenOperatorLibrary")
    params = list()
    params[["offset"]] = unbox(as.integer(offset))
    params[["limit"]] = unbox(as.integer(limit))
    url = self$getServiceUri(uri)
    response = self$client$post(url, body = params)
    if (response$status != 200) {
        self$onResponseError(response, "getTercenOperatorLibrary")
    } else {
        answer = createObjectFromJson(response$content)
    }
    return(answer)
}, getTercenWorkflowLibrary = function(offset, limit) {
    answer = NULL
    response = NULL
    uri = paste0("api/v1/d", "/", "getTercenWorkflowLibrary")
    params = list()
    params[["offset"]] = unbox(as.integer(offset))
    params[["limit"]] = unbox(as.integer(limit))
    url = self$getServiceUri(uri)
    response = self$client$post(url, body = params)
    if (response$status != 200) {
        self$onResponseError(response, "getTercenWorkflowLibrary")
    } else {
        answer = createObjectFromJson(response$content)
    }
    return(answer)
}, getTercenAppLibrary = function(offset, limit) {
    answer = NULL
    response = NULL
    uri = paste0("api/v1/d", "/", "getTercenAppLibrary")
    params = list()
    params[["offset"]] = unbox(as.integer(offset))
    params[["limit"]] = unbox(as.integer(limit))
    url = self$getServiceUri(uri)
    response = self$client$post(url, body = params)
    if (response$status != 200) {
        self$onResponseError(response, "getTercenAppLibrary")
    } else {
        answer = createObjectFromJson(response$content)
    }
    return(answer)
}))
