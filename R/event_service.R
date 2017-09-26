EventService <- R6::R6Class("EventService", inherit = HttpClientService, public = list(initialize = function(baseRestUri, 
    client) {
    super$initialize(baseRestUri, client)
    self$uri = "api/v1/evt"
}, listenTask = function(taskId) {
    answer = NULL
    response = NULL
    uri = paste0("api/v1/evt", "/", "listenTask")
    params = list()
    params[["taskId"]] = unbox(taskId)
    url = self$getServiceUri(uri)
    response = self$client$post(url, body = params)
    if (status_code(response) != 200) {
        self$onResponseError(response, "listenTask")
    } else {
        answer = content(response)
    }
    return(answer)
}))
