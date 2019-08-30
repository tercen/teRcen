#' TeamService
#'
#' @export
#' @format \code{\link{R6Class}} object.
#' @section Methods:
#' \describe{
#'    \item{\code{profiles(teamId)}}{method}
#'    \item{\code{resourceSummary(teamId)}}{method}
#' }
#' 
TeamService <- R6::R6Class("TeamService", inherit = HttpClientService, public = list(initialize = function(baseRestUri, 
    client) {
    super$initialize(baseRestUri, client)
    self$uri = "api/v1/team"
}, findTeamByNameByLastModifiedDate = function(startKey = NULL, endKey = NULL, limit = 20, 
    skip = 0, descending = TRUE, useFactory = FALSE) {
    return(self$findStartKeys("findTeamByNameByLastModifiedDate", startKey = startKey, 
        endKey = endKey, limit = limit, skip = skip, descending = descending, useFactory = useFactory))
}, findTeamByOwner = function(keys = NULL, useFactory = FALSE) {
    return(self$findKeys("teamByOwner", keys = keys, useFactory = useFactory))
}, findTeamByName = function(keys = NULL, useFactory = FALSE) {
    return(self$findKeys("teamByName", keys = keys, useFactory = useFactory))
}, profiles = function(teamId) {
    answer = NULL
    response = NULL
    uri = paste0("api/v1/team", "/", "profiles")
    params = list()
    params[["teamId"]] = unbox(teamId)
    url = self$getServiceUri(uri)
    response = self$client$post(url, body = params)
    if (response$status != 200) {
        self$onResponseError(response, "profiles")
    } else {
        answer = createObjectFromJson(response$content)
    }
    return(answer)
}, resourceSummary = function(teamId) {
    answer = NULL
    response = NULL
    uri = paste0("api/v1/team", "/", "resourceSummary")
    params = list()
    params[["teamId"]] = unbox(teamId)
    url = self$getServiceUri(uri)
    response = self$client$post(url, body = params)
    if (response$status != 200) {
        self$onResponseError(response, "resourceSummary")
    } else {
        answer = createObjectFromJson(response$content)
    }
    return(answer)
}))
