#' LockService
#'
#' @export
#' @format \code{\link{R6Class}} object.
#' @section Methods:
#' \describe{
#'    \item{\code{lock(name,wait)}}{method}
#'    \item{\code{releaseLock(lock)}}{method}
#' }
#' 
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
    response = self$client$post(url, body = params)
    if (response$status != 200) {
        self$onResponseError(response, "lock")
    } else {
        answer = createObjectFromJson(response$content)
    }
    return(answer)
}, releaseLock = function(lock) {
    answer = NULL
    response = NULL
    uri = paste0("api/v1/lock", "/", "releaseLock")
    params = list()
    params[["lock"]] = lock$toTson()
    url = self$getServiceUri(uri)
    response = self$client$post(url, body = params)
    if (response$status != 200) {
        self$onResponseError(response, "releaseLock")
    } else {
        answer = NULL
    }
    return(answer)
}))
