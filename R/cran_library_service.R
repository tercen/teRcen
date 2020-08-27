#' CranLibraryService
#'
#' @export
#' @format \code{\link{R6Class}} object.
#' @section Methods:
#' \describe{
#'    \item{\code{packagesGz(repoName)}}{method}
#'    \item{\code{packagesRds(repoName)}}{method}
#'    \item{\code{packages(repoName)}}{method}
#'    \item{\code{archive(repoName,package,filename)}}{method}
#'    \item{\code{package(repoName,package)}}{method}
#' }
#' 
CranLibraryService <- R6::R6Class("CranLibraryService", inherit = HttpClientService, 
    public = list(initialize = function(baseRestUri, client) {
        super$initialize(baseRestUri, client)
        self$uri = "api/v1/rlib"
    }, findByOwner = function(keys = NULL, useFactory = FALSE) {
        return(self$findKeys("findByOwner", keys = keys, useFactory = useFactory))
    }, findByFileId = function(keys = NULL, useFactory = FALSE) {
        return(self$findKeys("findByFileId", keys = keys, useFactory = useFactory))
    }, findByOwnerNameVersion = function(startKey = NULL, endKey = NULL, limit = 20, 
        skip = 0, descending = TRUE, useFactory = FALSE) {
        return(self$findStartKeys("findByOwnerNameVersion", startKey = startKey, 
            endKey = endKey, limit = limit, skip = skip, descending = descending, 
            useFactory = useFactory))
    }, packagesGz = function(repoName) {
        answer = NULL
        response = NULL
        uri = paste0("api/v1/rlib", "/", "packagesGz")
        params = list()
        params[["repoName"]] = unbox(repoName)
        url = self$getServiceUri(uri)
        response = self$client$get(url, query = list(params = toJSON(params)))
        if (response$status != 200) {
            self$onResponseError(response, "packagesGz")
        } else {
            answer = response$content
        }
        return(answer)
    }, packagesRds = function(repoName) {
        answer = NULL
        response = NULL
        uri = paste0("api/v1/rlib", "/", "packagesRds")
        params = list()
        params[["repoName"]] = unbox(repoName)
        url = self$getServiceUri(uri)
        response = self$client$get(url, query = list(params = toJSON(params)))
        if (response$status != 200) {
            self$onResponseError(response, "packagesRds")
        } else {
            answer = response$content
        }
        return(answer)
    }, packages = function(repoName) {
        answer = NULL
        response = NULL
        uri = paste0("api/v1/rlib", "/", "packages")
        params = list()
        params[["repoName"]] = unbox(repoName)
        url = self$getServiceUri(uri)
        response = self$client$get(url, query = list(params = toJSON(params)))
        if (response$status != 200) {
            self$onResponseError(response, "packages")
        } else {
            answer = response$content
        }
        return(answer)
    }, archive = function(repoName, package, filename) {
        answer = NULL
        response = NULL
        uri = paste0("api/v1/rlib", "/", "archive")
        params = list()
        params[["repoName"]] = unbox(repoName)
        params[["package"]] = unbox(package)
        params[["filename"]] = unbox(filename)
        url = self$getServiceUri(uri)
        response = self$client$get(url, query = list(params = toJSON(params)))
        if (response$status != 200) {
            self$onResponseError(response, "archive")
        } else {
            answer = response$content
        }
        return(answer)
    }, package = function(repoName, package) {
        answer = NULL
        response = NULL
        uri = paste0("api/v1/rlib", "/", "package")
        params = list()
        params[["repoName"]] = unbox(repoName)
        params[["package"]] = unbox(package)
        url = self$getServiceUri(uri)
        response = self$client$get(url, query = list(params = toJSON(params)))
        if (response$status != 200) {
            self$onResponseError(response, "package")
        } else {
            answer = response$content
        }
        return(answer)
    }))
