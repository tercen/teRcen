FileService <- R6::R6Class("FileService", inherit = HttpClientService, public = list(initialize = function(baseRestUri, 
    client) {
    super$initialize(baseRestUri, client)
    self$uri = "api/v1/file"
}, upload = function(file, bytes) {
    answer = NULL
    response = NULL
    uri = paste0("api/v1/file", "/", "upload")
    parts = list()
    parts[[1]] = MultiPart$new(list(`content-type` = unbox("application/json")), content = list(file$toTson()))
    parts[[2]] = MultiPart$new(list(`content-type` = unbox("application/octet-stream")), content = bytes)
     
    response = self$client$multipart(self$getServiceUri(uri), 
                                     body = lapply(parts, function(part) part$toTson()))
    if (response$status != 200) {
        self$onResponseError(response, "upload")
    } else {
        answer = createObjectFromJson(response$content)
    }
    return(answer)
}, download = function(fileDocumentId) {
    answer = NULL
    response = NULL
    uri = paste0("api/v1/file", "/", "download")
    params = list()
    params[["fileDocumentId"]] = unbox(fileDocumentId)
    url = self$getServiceUri(uri)
    url$query = list(params = rtson::toJSON(params))
    response = self$client$get(url)
    if (response$status != 200) {
        self$onResponseError(response, "download")
    } else {
        answer = response$content
    }
    return(answer)
}))
