LockService <- R6::R6Class("LockService", inherit = HttpClientService, public = list(initialize = function(baseRestUri, 
    client) {
    super$initialize(baseRestUri, client)
    self$uri = "api/v1/lock"
}, lock = function(name, wait) {
    answer = NULL
    response = NULL
    uri = paste0("api/v1/lock", "/", "lock")
    params = list()
    params[["name"]] = unbox(name)
    params[["wait"]] = unbox(as.integer(wait))
    url = self$getServiceUri(uri)
    response = self$client$post(url, body = rtson::toTSON(params), encode = "raw")
    if (status_code(response) != 200) {
        self$onResponseError(response, "lock")
    } else {
        answer = createObjectFromJson(rtson::fromTSON(content(response)))
    }
    return(answer)
}, releaseLock = function(lock) {
    answer = NULL
    response = NULL
    uri = paste0("api/v1/lock", "/", "releaseLock")
    params = list()
    params[["lock"]] = lock$toTson()
    url = self$getServiceUri(uri)
    response = self$client$post(url, body = rtson::toTSON(params), encode = "raw")
    if (status_code(response) != 200) {
        self$onResponseError(response, "releaseLock")
    } else {
        answer = NULL
    }
    return(answer)
}))
