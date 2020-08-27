#' ProjectService
#'
#' @export
#' @format \code{\link{R6Class}} object.
#' @section Methods:
#' \describe{
#'    \item{\code{profiles(projectId)}}{method}
#'    \item{\code{resourceSummary(projectId)}}{method}
#'    \item{\code{explore(category,start,limit)}}{method}
#'    \item{\code{recentProjects(userId)}}{method}
#'    \item{\code{cloneProject(projectId,project)}}{method}
#' }
#' 
ProjectService <- R6::R6Class("ProjectService", inherit = HttpClientService, public = list(initialize = function(baseRestUri, 
    client) {
    super$initialize(baseRestUri, client)
    self$uri = "api/v1/project"
}, findByIsPublicAndLastModifiedDate = function(startKey = NULL, endKey = NULL, limit = 20, 
    skip = 0, descending = TRUE, useFactory = FALSE) {
    return(self$findStartKeys("findByIsPublicAndLastModifiedDate", startKey = startKey, 
        endKey = endKey, limit = limit, skip = skip, descending = descending, useFactory = useFactory))
}, findByTeamAndIsPublicAndLastModifiedDate = function(startKey = NULL, endKey = NULL, 
    limit = 20, skip = 0, descending = TRUE, useFactory = FALSE) {
    return(self$findStartKeys("findByTeamAndIsPublicAndLastModifiedDate", startKey = startKey, 
        endKey = endKey, limit = limit, skip = skip, descending = descending, useFactory = useFactory))
}, profiles = function(projectId) {
    answer = NULL
    response = NULL
    uri = paste0("api/v1/project", "/", "profiles")
    params = list()
    params[["projectId"]] = unbox(projectId)
    url = self$getServiceUri(uri)
    response = self$client$post(url, body = params)
    if (response$status != 200) {
        self$onResponseError(response, "profiles")
    } else {
        answer = createObjectFromJson(response$content)
    }
    return(answer)
}, resourceSummary = function(projectId) {
    answer = NULL
    response = NULL
    uri = paste0("api/v1/project", "/", "resourceSummary")
    params = list()
    params[["projectId"]] = unbox(projectId)
    url = self$getServiceUri(uri)
    response = self$client$post(url, body = params)
    if (response$status != 200) {
        self$onResponseError(response, "resourceSummary")
    } else {
        answer = createObjectFromJson(response$content)
    }
    return(answer)
}, explore = function(category, start, limit) {
    answer = NULL
    response = NULL
    uri = paste0("api/v1/project", "/", "explore")
    params = list()
    params[["category"]] = unbox(category)
    params[["start"]] = unbox(as.integer(start))
    params[["limit"]] = unbox(as.integer(limit))
    url = self$getServiceUri(uri)
    response = self$client$post(url, body = params)
    if (response$status != 200) {
        self$onResponseError(response, "explore")
    } else {
        answer = createObjectFromJson(response$content)
    }
    return(answer)
}, recentProjects = function(userId) {
    answer = NULL
    response = NULL
    uri = paste0("api/v1/project", "/", "recentProjects")
    params = list()
    params[["userId"]] = unbox(userId)
    url = self$getServiceUri(uri)
    response = self$client$post(url, body = params)
    if (response$status != 200) {
        self$onResponseError(response, "recentProjects")
    } else {
        answer = createObjectFromJson(response$content)
    }
    return(answer)
}, cloneProject = function(projectId, project) {
    answer = NULL
    response = NULL
    uri = paste0("api/v1/project", "/", "cloneProject")
    params = list()
    params[["projectId"]] = unbox(projectId)
    params[["project"]] = project$toTson()
    url = self$getServiceUri(uri)
    response = self$client$post(url, body = params)
    if (response$status != 200) {
        self$onResponseError(response, "cloneProject")
    } else {
        answer = createObjectFromJson(response$content)
    }
    return(answer)
}))
