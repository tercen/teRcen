WorkflowService <- R6::R6Class("WorkflowService", inherit = HttpClientService, public = list(initialize = function(baseRestUri, 
    client) {
    super$initialize(baseRestUri, client)
    self$uri = "workflow"
}, getCubeQuery = function(workflowId, stepId) {
    answer = NULL
    response = NULL
    uri = paste0("workflow", "/", "getCubeQuery")
    params = list()
    params[["workflowId"]] = unbox(workflowId)
    params[["stepId"]] = unbox(stepId)
    url = self$getServiceUri(uri)
    response = self$client$post(url, body = params)
    if (status_code(response) != 200) {
        self$onResponseError(response, "getCubeQuery")
    } else {
        answer = createObjectFromJson(content(response))
    }
    return(answer)
}))
