EventService <- R6::R6Class("EventService", inherit = HttpClientService, public = list(initialize = function(baseRestUri, 
    client) {
    super$initialize(baseRestUri, client)
    self$uri = "api/v1/evt"
}, sendChannel = function(channel, evt) {
    answer = NULL
    response = NULL
    uri = paste0("api/v1/evt", "/", "sendChannel")
    params = list()
    params[["channel"]] = unbox(channel)
    params[["evt"]] = evt$toTson()
    url = self$getServiceUri(uri)
    response = self$client$post(url, body = rtson::toTSON(params), encode = "raw")
    if (status_code(response) != 200) {
        self$onResponseError(response, "sendChannel")
    } else {
        answer = NULL
    }
    return(answer)
}, channel = function(name) {
    answer = NULL
    response = NULL
    uri = paste0("api/v1/evt", "/", "channel")
    params = list()
    params[["name"]] = unbox(name)
    url = self$getServiceUri(uri)
    response = self$client$post(url, body = rtson::toTSON(params), encode = "raw")
    if (status_code(response) != 200) {
        self$onResponseError(response, "channel")
    } else {
        answer = content(response)
    }
    return(answer)
}, listenTask = function(taskId, start) {
    answer = NULL
    response = NULL
    uri = paste0("api/v1/evt", "/", "listenTask")
    params = list()
    params[["taskId"]] = unbox(taskId)
    params[["start"]] = unbox(start)
    url = self$getServiceUri(uri)
    response = self$client$post(url, body = rtson::toTSON(params), encode = "raw")
    if (status_code(response) != 200) {
        self$onResponseError(response, "listenTask")
    } else {
        answer = content(response)
    }
    return(answer)
}, onTaskState = function(taskId) {
    answer = NULL
    response = NULL
    uri = paste0("api/v1/evt", "/", "onTaskState")
    params = list()
    params[["taskId"]] = unbox(taskId)
    url = self$getServiceUri(uri)
    response = self$client$post(url, body = rtson::toTSON(params), encode = "raw")
    if (status_code(response) != 200) {
        self$onResponseError(response, "onTaskState")
    } else {
        answer = content(response)
    }
    return(answer)
}, taskListenerCount = function(taskId) {
    answer = NULL
    response = NULL
    uri = paste0("api/v1/evt", "/", "taskListenerCount")
    params = list()
    params[["taskId"]] = unbox(taskId)
    url = self$getServiceUri(uri)
    response = self$client$post(url, body = rtson::toTSON(params), encode = "raw")
    if (status_code(response) != 200) {
        self$onResponseError(response, "taskListenerCount")
    } else {
        answer = rtson::fromTSON(content(response))[[1]]
    }
    return(answer)
}))
