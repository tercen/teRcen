ProjectService <- R6::R6Class("ProjectService", inherit = HttpClientService, public = list(initialize = function(baseRestUri, 
    client) {
    super$initialize(baseRestUri, client)
    self$uri = "project"
}, storageSummary = function(projectId) {
    answer = NULL
    response = NULL
    uri = paste0("project", "/", "storageSummary")
    params = list()
    params[["projectId"]] = unbox(projectId)
    url = self$getServiceUri(uri)
    response = self$client$post(url, body = params)
    if (status_code(response) != 200) {
        self$onResponseError(response, "storageSummary")
    } else {
        answer = createObjectFromJson(content(response))
    }
    return(answer)
}))
