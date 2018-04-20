PersistentService <- R6::R6Class("PersistentService", inherit = HttpClientService, 
    public = list(initialize = function(baseRestUri, client) {
        super$initialize(baseRestUri, client)
        self$uri = "api/v1/po"
    }, findWorkflowByTask = function(keys = NULL, useFactory = FALSE) {
        return(self$findKeys("findWorkflowByTask", keys = keys, useFactory = useFactory))
    }, findDeleted = function(keys = NULL, useFactory = FALSE) {
        return(self$findKeys("findDeleted", keys = keys, useFactory = useFactory))
    }, findByKind = function(keys = NULL, useFactory = FALSE) {
        return(self$findKeys("findByKind", keys = keys, useFactory = useFactory))
    }, summary = function(teamOrProjectId) {
        answer = NULL
        response = NULL
        uri = paste0("api/v1/po", "/", "summary")
        params = list()
        params[["teamOrProjectId"]] = unbox(teamOrProjectId)
        url = self$getServiceUri(uri)
        response = self$client$post(url, body = rtson::toTSON(params), encode = "raw")
        if (status_code(response) != 200) {
            self$onResponseError(response, "summary")
        } else {
            answer = createObjectFromJson(rtson::fromTSON(content(response)))
        }
        return(answer)
    }))
