WorkerService <- R6::R6Class("WorkerService", inherit = HttpClientService, public = list(initialize = function(baseRestUri, 
    client) {
    super$initialize(baseRestUri, client)
    self$uri = "api/v1/worker"
}, exec = function(task) {
    answer = NULL
    response = NULL
    uri = paste0("api/v1/worker", "/", "exec")
    params = list()
    params[["task"]] = task$toTson()
    url = self$getServiceUri(uri)
    response = self$client$post(url, body = params)
    if (status_code(response) != 200) {
        self$onResponseError(response, "exec")
    } else {
        answer = NULL
    }
    return(answer)
}))
