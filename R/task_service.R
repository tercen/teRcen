#' TaskService
#'
#' @export
#' @format \code{\link{R6Class}} object.
#' @section Methods:
#' \describe{
#'    \item{\code{runTask(taskId)}}{method}
#'    \item{\code{cancelTask(taskId)}}{method}
#'    \item{\code{waitDone(taskId)}}{method}
#'    \item{\code{updateWorker(worker)}}{method}
#'    \item{\code{taskDurationByTeam(teamId,year,month)}}{method}
#' }
#' 
TaskService <- R6::R6Class("TaskService", inherit = HttpClientService, public = list(initialize = function(baseRestUri, 
    client) {
    super$initialize(baseRestUri, client)
    self$uri = "api/v1/task"
}, findByHash = function(keys = NULL, useFactory = FALSE) {
    return(self$findKeys("findByHash", keys = keys, useFactory = useFactory))
}, findGCTaskByLastModifiedDate = function(startKey = NULL, endKey = NULL, limit = 20, 
    skip = 0, descending = TRUE, useFactory = FALSE) {
    return(self$findStartKeys("findGCTaskByLastModifiedDate", startKey = startKey, 
        endKey = endKey, limit = limit, skip = skip, descending = descending, useFactory = useFactory))
}, runTask = function(taskId) {
    answer = NULL
    response = NULL
    uri = paste0("api/v1/task", "/", "runTask")
    params = list()
    params[["taskId"]] = unbox(taskId)
    url = self$getServiceUri(uri)
    response = self$client$post(url, body = params)
    if (response$status != 200) {
        self$onResponseError(response, "runTask")
    } else {
        answer = NULL
    }
    return(answer)
}, cancelTask = function(taskId) {
    answer = NULL
    response = NULL
    uri = paste0("api/v1/task", "/", "cancelTask")
    params = list()
    params[["taskId"]] = unbox(taskId)
    url = self$getServiceUri(uri)
    response = self$client$post(url, body = params)
    if (response$status != 200) {
        self$onResponseError(response, "cancelTask")
    } else {
        answer = NULL
    }
    return(answer)
}, waitDone = function(taskId) {
    answer = NULL
    response = NULL
    uri = paste0("api/v1/task", "/", "waitDone")
    params = list()
    params[["taskId"]] = unbox(taskId)
    url = self$getServiceUri(uri)
    response = self$client$post(url, body = params)
    if (response$status != 200) {
        self$onResponseError(response, "waitDone")
    } else {
        answer = createObjectFromJson(response$content)
    }
    return(answer)
}, updateWorker = function(worker) {
    answer = NULL
    response = NULL
    uri = paste0("api/v1/task", "/", "updateWorker")
    params = list()
    params[["worker"]] = worker$toTson()
    url = self$getServiceUri(uri)
    response = self$client$post(url, body = params)
    if (response$status != 200) {
        self$onResponseError(response, "updateWorker")
    } else {
        answer = NULL
    }
    return(answer)
}, taskDurationByTeam = function(teamId, year, month) {
    answer = NULL
    response = NULL
    uri = paste0("api/v1/task", "/", "taskDurationByTeam")
    params = list()
    params[["teamId"]] = unbox(teamId)
    params[["year"]] = unbox(as.integer(year))
    params[["month"]] = unbox(as.integer(month))
    url = self$getServiceUri(uri)
    response = self$client$post(url, body = params)
    if (response$status != 200) {
        self$onResponseError(response, "taskDurationByTeam")
    } else {
        answer = response$content[[1]]
    }
    return(answer)
}))
