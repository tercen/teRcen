#' FolderService
#'
#' @export
#' @format \code{\link{R6Class}} object.
#' @section Methods:
#' \describe{
#'    \item{\code{getOrCreate(projectId,path)}}{method}
#' }
#' 
FolderService <- R6::R6Class("FolderService", inherit = HttpClientService, public = list(initialize = function(baseRestUri, 
    client) {
    super$initialize(baseRestUri, client)
    self$uri = "api/v1/folder"
}, findFolderByParentFolderAndName = function(startKey = NULL, endKey = NULL, limit = 20, 
    skip = 0, descending = TRUE, useFactory = FALSE) {
    return(self$findStartKeys("findFolderByParentFolderAndName", startKey = startKey, 
        endKey = endKey, limit = limit, skip = skip, descending = descending, useFactory = useFactory))
}, getOrCreate = function(projectId, path) {
    answer = NULL
    response = NULL
    uri = paste0("api/v1/folder", "/", "getOrCreate")
    params = list()
    params[["projectId"]] = unbox(projectId)
    params[["path"]] = unbox(path)
    url = self$getServiceUri(uri)
    response = self$client$post(url, body = params)
    if (response$status != 200) {
        self$onResponseError(response, "getOrCreate")
    } else {
        answer = createObjectFromJson(response$content)
    }
    return(answer)
}))
