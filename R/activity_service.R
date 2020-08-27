#' ActivityService
#'
#' @export
#' @format \code{\link{R6Class}} object.
#' @section Methods:
#' \describe{
#'    \item{\code{getPublicActivityCount(kind,limit)}}{method}
#' }
#' 
ActivityService <- R6::R6Class("ActivityService", inherit = HttpClientService, public = list(initialize = function(baseRestUri, 
    client) {
    super$initialize(baseRestUri, client)
    self$uri = "api/v1/activity"
}, findByUserAndDate = function(startKey = NULL, endKey = NULL, limit = 20, skip = 0, 
    descending = TRUE, useFactory = FALSE) {
    return(self$findStartKeys("findByUserAndDate", startKey = startKey, endKey = endKey, 
        limit = limit, skip = skip, descending = descending, useFactory = useFactory))
}, findByTeamAndDate = function(startKey = NULL, endKey = NULL, limit = 20, skip = 0, 
    descending = TRUE, useFactory = FALSE) {
    return(self$findStartKeys("findByTeamAndDate", startKey = startKey, endKey = endKey, 
        limit = limit, skip = skip, descending = descending, useFactory = useFactory))
}, findByProjectAndDate = function(startKey = NULL, endKey = NULL, limit = 20, skip = 0, 
    descending = TRUE, useFactory = FALSE) {
    return(self$findStartKeys("findByProjectAndDate", startKey = startKey, endKey = endKey, 
        limit = limit, skip = skip, descending = descending, useFactory = useFactory))
}, getPublicActivityCount = function(kind, limit) {
    answer = NULL
    response = NULL
    uri = paste0("api/v1/activity", "/", "getPublicActivityCount")
    params = list()
    params[["kind"]] = unbox(kind)
    params[["limit"]] = unbox(as.integer(limit))
    url = self$getServiceUri(uri)
    response = self$client$post(url, body = params)
    if (response$status != 200) {
        self$onResponseError(response, "getPublicActivityCount")
    } else {
        answer = createObjectFromJson(response$content)
    }
    return(answer)
}))
