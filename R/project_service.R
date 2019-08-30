#' ProjectService
#'
#' @export
#' @format \code{\link{R6Class}} object.
#' @section Methods:
#' \describe{
#'    \item{\code{profiles(projectId)}}{method}
#'    \item{\code{resourceSummary(projectId)}}{method}
#' }
#' 
ProjectService <- R6::R6Class("ProjectService", inherit = HttpClientService, public = list(initialize = function(baseRestUri, 
    client) {
    super$initialize(baseRestUri, client)
    self$uri = "api/v1/project"
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
}))
