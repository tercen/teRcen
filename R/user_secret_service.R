UserSecretService <- R6::R6Class("UserSecretService", inherit = HttpClientService, 
    public = list(initialize = function(baseRestUri, client) {
        super$initialize(baseRestUri, client)
        self$uri = "userSecret"
    }, findSecretByUserId = function(keys = NULL, useFactory = FALSE) {
        return(self$findKeys("secret", keys = keys, useFactory = useFactory))
    }))
