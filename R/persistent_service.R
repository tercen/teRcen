PersistentService <- R6::R6Class("PersistentService", inherit = HttpClientService, 
    public = list(initialize = function(baseRestUri, client) {
        super$initialize(baseRestUri, client)
        self$uri = "po"
    }, findWorkflowByTask = function(keys = NULL, useFactory = FALSE) {
        return(self$findKeys("findWorkflowByTask", keys = keys, useFactory = useFactory))
    }, findDeleted = function(keys = NULL, useFactory = FALSE) {
        return(self$findKeys("findDeleted", keys = keys, useFactory = useFactory))
    }, findByKind = function(keys = NULL, useFactory = FALSE) {
        return(self$findKeys("findByKind", keys = keys, useFactory = useFactory))
    }))
