ProjectDocumentService <- R6::R6Class("ProjectDocumentService", inherit = HttpClientService, 
    public = list(initialize = function(baseRestUri, client) {
        super$initialize(baseRestUri, client)
        self$uri = "api/v1/pd"
    }, findProjectObjectsByLastModifiedDate = function(startKey = NULL, endKey = NULL, 
        limit = 20, skip = 0, descending = TRUE, useFactory = FALSE) {
        return(self$findStartKeys("findProjectObjectsByLastModifiedDate", startKey = startKey, 
            endKey = endKey, limit = limit, skip = skip, descending = descending, 
            useFactory = useFactory))
    }, findWorkflowByLastModifiedDate = function(startKey = NULL, endKey = NULL, 
        limit = 20, skip = 0, descending = TRUE, useFactory = FALSE) {
        return(self$findStartKeys("findWorkflowByLastModifiedDate", startKey = startKey, 
            endKey = endKey, limit = limit, skip = skip, descending = descending, 
            useFactory = useFactory))
    }, findSchemaByLastModifiedDate = function(startKey = NULL, endKey = NULL, limit = 20, 
        skip = 0, descending = TRUE, useFactory = FALSE) {
        return(self$findStartKeys("findSchemaByLastModifiedDate", startKey = startKey, 
            endKey = endKey, limit = limit, skip = skip, descending = descending, 
            useFactory = useFactory))
    }, findWorkflowByOwnerAndLastModifiedDate = function(startKey = NULL, endKey = NULL, 
        limit = 20, skip = 0, descending = TRUE, useFactory = FALSE) {
        return(self$findStartKeys("findWorkflowByOwnerAndLastModifiedDate", startKey = startKey, 
            endKey = endKey, limit = limit, skip = skip, descending = descending, 
            useFactory = useFactory))
    }, findSchemaByOwnerAndLastModifiedDate = function(startKey = NULL, endKey = NULL, 
        limit = 20, skip = 0, descending = TRUE, useFactory = FALSE) {
        return(self$findStartKeys("findSchemaByOwnerAndLastModifiedDate", startKey = startKey, 
            endKey = endKey, limit = limit, skip = skip, descending = descending, 
            useFactory = useFactory))
    }, findWorkflowBySchema = function(keys = NULL, useFactory = FALSE) {
        return(self$findKeys("findWorkflowBySchema", keys = keys, useFactory = useFactory))
    }, findWorkflowByOperator = function(keys = NULL, useFactory = FALSE) {
        return(self$findKeys("findWorkflowByOperator", keys = keys, useFactory = useFactory))
    }, findWorkflowTemplateByOwnerCreatedDate = function(startKey = NULL, endKey = NULL, 
        limit = 20, skip = 0, descending = TRUE, useFactory = FALSE) {
        return(self$findStartKeys("findWorkflowTemplateByOwnerCreatedDate", startKey = startKey, 
            endKey = endKey, limit = limit, skip = skip, descending = descending, 
            useFactory = useFactory))
    }, findWorkflowAppByOwnerCreatedDate = function(startKey = NULL, endKey = NULL, 
        limit = 20, skip = 0, descending = TRUE, useFactory = FALSE) {
        return(self$findStartKeys("findWorkflowAppByOwnerCreatedDate", startKey = startKey, 
            endKey = endKey, limit = limit, skip = skip, descending = descending, 
            useFactory = useFactory))
    }))
