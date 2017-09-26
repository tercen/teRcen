GarbageCollectorService <- R6::R6Class("GarbageCollectorService", inherit = HttpClientService, 
    public = list(initialize = function(baseRestUri, client) {
        super$initialize(baseRestUri, client)
        self$uri = "api/v1/gc"
    }))
