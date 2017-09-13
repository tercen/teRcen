TableSchemaService <- R6::R6Class("TableSchemaService", inherit = HttpClientService, 
    public = list(initialize = function(baseRestUri, client) {
        super$initialize(baseRestUri, client)
        self$uri = "schema"
    }, findByQueryHash = function(keys = NULL, useFactory = FALSE) {
        return(self$findKeys("findByQueryHash", keys = keys, useFactory = useFactory))
    }, findSchemaByDataDirectory = function(startKey = NULL, endKey = NULL, limit = 20, 
        skip = 0, descending = TRUE, useFactory = FALSE) {
        return(self$findStartKeys("findSchemaByDataDirectory", startKey = startKey, 
            endKey = endKey, limit = limit, skip = skip, descending = descending, 
            useFactory = useFactory))
    }, select = function(tableId, cnames, offset, limit) {
        answer = NULL
        response = NULL
        uri = paste0("schema", "/", "select")
        params = list()
        params[["tableId"]] = unbox(tableId)
        params[["cnames"]] = cnames
        params[["offset"]] = unbox(offset)
        params[["limit"]] = unbox(limit)
        url = self$getServiceUri(uri)
        response = self$client$post(url, body = params)
        if (status_code(response) != 200) {
            self$onResponseError(response, "select")
        } else {
            answer = createObjectFromJson(rtson::fromTSON(content(response)))
        }
        return(answer)
    }, selectStream = function(tableId, cnames, offset, limit) {
        answer = NULL
        response = NULL
        uri = paste0("schema", "/", "selectStream")
        params = list()
        params[["tableId"]] = unbox(tableId)
        params[["cnames"]] = cnames
        params[["offset"]] = unbox(offset)
        params[["limit"]] = unbox(limit)
        url = self$getServiceUri(uri)
        response = self$client$post(url, body = params)
        if (status_code(response) != 200) {
            self$onResponseError(response, "selectStream")
        } else {
            answer = content(response)
        }
        return(answer)
    }))
