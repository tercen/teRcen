TaskService <- R6::R6Class("TaskService", inherit = HttpClientService, public = list(initialize = function(baseRestUri, 
    client) {
    super$initialize(baseRestUri, client)
    self$uri = "task"
}, findByHash = function(keys = NULL, useFactory = FALSE) {
    return(self$findKeys("findByHash", keys = keys, useFactory = useFactory))
}, findGCTaskByLastModifiedDate = function(startKey = NULL, endKey = NULL, limit = 20, 
    skip = 0, descending = TRUE, useFactory = FALSE) {
    return(self$findStartKeys("findGCTaskByLastModifiedDate", startKey = startKey, 
        endKey = endKey, limit = limit, skip = skip, descending = descending, useFactory = useFactory))
}, waitDone = function(taskId) {
    answer = NULL
    response = NULL
    uri = paste0("task", "/", "waitDone")
    params = list()
    params[["taskId"]] = unbox(taskId)
    url = self$getServiceUri(uri)
    response = self$client$post(url, body = params)
    if (status_code(response) != 200) {
        self$onResponseError(response, "waitDone")
    } else {
        answer = createObjectFromJson(content(response))
    }
    return(answer)
}, updateWorker = function(worker) {
    answer = NULL
    response = NULL
    uri = paste0("task", "/", "updateWorker")
    params = list()
    params[["worker"]] = worker$toTson()
    url = self$getServiceUri(uri)
    response = self$client$post(url, body = params)
    if (status_code(response) != 200) {
        self$onResponseError(response, "updateWorker")
    } else {
        answer = NULL
    }
    return(answer)
}))
