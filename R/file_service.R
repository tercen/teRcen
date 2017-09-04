FileService <- R6::R6Class("FileService", inherit = HttpClientService, public = list(initialize = function(baseRestUri, 
    client) {
    super$initialize(baseRestUri, client)
    self$uri = "file"
}, upload = function(file, bytes) {
    answer = NULL
    response = NULL
    uri = paste0("file", "/", "upload")
    parts = list()
    parts[[1]] = MultiPart$new(list(`Content-Type` = "application/json"), string = jsonlite::toJSON(list(file$toTson())))
    parts[[2]] = MultiPart$new(list(`Content-Type` = "application/octet-stream"), 
        bytes = bytes)
    frontier = "ab63a1363ab349aa8627be56b0479de2"
    bodyBytes = MultiPartMixTransformer$new(frontier)$encode(parts)
    headers = c(`Content-Type` = paste0("multipart/mixed; boundary=", frontier))
    response = self$client$post(self$getServiceUri(uri), headers = headers, body = bodyBytes, 
        encode = "raw")
    if (status_code(response) != 200) {
        self$onResponseError(response, "upload")
    } else {
        answer = createObjectFromJson(content(response))
    }
    return(answer)
}))
