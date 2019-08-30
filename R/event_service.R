#' EventService
#'
#' @export
#' @format \code{\link{R6Class}} object.
#' @section Methods:
#' \describe{
#'    \item{\code{sendChannel(channel,evt)}}{method}
#'    \item{\code{channel(name)}}{method}
#'    \item{\code{listenTaskChannel(taskId,start)}}{method}
#'    \item{\code{onTaskState(taskId)}}{method}
#'    \item{\code{taskListenerCount(taskId)}}{method}
#' }
#' 
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
    response = self$client$post(url, body = params)
    if (response$status != 200) {
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
    response = self$client$post(url, body = params)
    if (response$status != 200) {
        self$onResponseError(response, "channel")
    } else {
        answer = response$content
    }
    return(answer)
}, listenTaskChannel = function(taskId, start) {
    answer = NULL
    response = NULL
    uri = paste0("api/v1/evt", "/", "listenTaskChannel")
    params = list()
    params[["taskId"]] = unbox(taskId)
    params[["start"]] = unbox(start)
    url = self$getServiceUri(uri)
    response = self$client$post(url, body = params)
    if (response$status != 200) {
        self$onResponseError(response, "listenTaskChannel")
    } else {
        answer = response$content
    }
    return(answer)
}, onTaskState = function(taskId) {
    answer = NULL
    response = NULL
    uri = paste0("api/v1/evt", "/", "onTaskState")
    params = list()
    params[["taskId"]] = unbox(taskId)
    url = self$getServiceUri(uri)
    response = self$client$post(url, body = params)
    if (response$status != 200) {
        self$onResponseError(response, "onTaskState")
    } else {
        answer = response$content
    }
    return(answer)
}, taskListenerCount = function(taskId) {
    answer = NULL
    response = NULL
    uri = paste0("api/v1/evt", "/", "taskListenerCount")
    params = list()
    params[["taskId"]] = unbox(taskId)
    url = self$getServiceUri(uri)
    response = self$client$post(url, body = params)
    if (response$status != 200) {
        self$onResponseError(response, "taskListenerCount")
    } else {
        answer = response$content[[1]]
    }
    return(answer)
}))
