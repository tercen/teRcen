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
    params[["offset"]] = unbox(offset)
    params[["limit"]] = unbox(limit)
    url = self$getServiceUri(uri)
    response = self$client$post(url, body = params)
    if (status_code(response) != 200) {
        self$onResponseError(response, "getTercenOperatorLibrary")
    } else {
        answer = createObjectFromJson(content(response))
    }
    return(answer)
}, getTercenWorkflowLibrary = function(offset, limit) {
    answer = NULL
    response = NULL
    uri = paste0("api/v1/d", "/", "getTercenWorkflowLibrary")
    params = list()
    params[["offset"]] = unbox(offset)
    params[["limit"]] = unbox(limit)
    url = self$getServiceUri(uri)
    response = self$client$post(url, body = params)
    if (status_code(response) != 200) {
        self$onResponseError(response, "getTercenWorkflowLibrary")
    } else {
        answer = createObjectFromJson(content(response))
    }
    return(answer)
}, getTercenAppLibrary = function(offset, limit) {
    answer = NULL
    response = NULL
    uri = paste0("api/v1/d", "/", "getTercenAppLibrary")
    params = list()
    params[["offset"]] = unbox(offset)
    params[["limit"]] = unbox(limit)
    url = self$getServiceUri(uri)
    response = self$client$post(url, body = params)
    if (status_code(response) != 200) {
        self$onResponseError(response, "getTercenAppLibrary")
    } else {
        answer = createObjectFromJson(content(response))
    }
    return(answer)
}))
