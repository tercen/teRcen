WorkflowService <- R6::R6Class("WorkflowService", inherit = HttpClientService, public = list(initialize = function(baseRestUri, 
    client) {
    super$initialize(baseRestUri, client)
    self$uri = "api/v1/workflow"
}, getCubeQuery = function(workflowId, stepId) {
    answer = NULL
    response = NULL
    uri = paste0("api/v1/workflow", "/", "getCubeQuery")
    params = list()
    params[["workflowId"]] = unbox(workflowId)
    params[["stepId"]] = unbox(stepId)
    url = self$getServiceUri(uri)
    response = self$client$post(url, body = params)
    if (response$status != 200) {
        self$onResponseError(response, "getCubeQuery")
    } else {
        answer = createObjectFromJson(response$content)
    }
    return(answer)
}, copy = function(workflowId) {
    answer = NULL
    response = NULL
    uri = paste0("api/v1/workflow", "/", "copy")
    params = list()
    params[["workflowId"]] = unbox(workflowId)
    url = self$getServiceUri(uri)
    response = self$client$post(url, body = params)
    if (response$status != 200) {
        self$onResponseError(response, "copy")
    } else {
        answer = createObjectFromJson(response$content)
    }
    return(answer)
}))
