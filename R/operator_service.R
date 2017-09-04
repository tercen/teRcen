OperatorService <- R6::R6Class("OperatorService", inherit = HttpClientService, public = list(initialize = function(baseRestUri, 
    client) {
    super$initialize(baseRestUri, client)
    self$uri = "operator"
}))
