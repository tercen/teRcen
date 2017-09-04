TeamService <- R6::R6Class("TeamService", inherit = HttpClientService, public = list(initialize = function(baseRestUri, 
    client) {
    super$initialize(baseRestUri, client)
    self$uri = "team"
}, findTeamByName = function(keys = NULL, useFactory = FALSE) {
    return(self$findKeys("teamByName", keys = keys, useFactory = useFactory))
}))
