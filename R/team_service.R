TeamService <- R6::R6Class("TeamService", inherit = HttpClientService, public = list(initialize = function(baseRestUri, 
    client) {
    super$initialize(baseRestUri, client)
    self$uri = "team"
}, findTeamByNameByLastModifiedDate = function(startKey = NULL, endKey = NULL, limit = 20, 
    skip = 0, descending = TRUE, useFactory = FALSE) {
    return(self$findStartKeys("findTeamByNameByLastModifiedDate", startKey = startKey, 
        endKey = endKey, limit = limit, skip = skip, descending = descending, useFactory = useFactory))
}, findTeamByOwner = function(keys = NULL, useFactory = FALSE) {
    return(self$findKeys("teamByOwner", keys = keys, useFactory = useFactory))
}, findTeamByName = function(keys = NULL, useFactory = FALSE) {
    return(self$findKeys("teamByName", keys = keys, useFactory = useFactory))
}, storageInUse = function(teamName) {
    answer = NULL
    response = NULL
    uri = paste0("team", "/", "storageInUse")
    params = list()
    params[["teamName"]] = unbox(teamName)
    url = self$getServiceUri(uri)
    response = self$client$post(url, body = params)
    if (status_code(response) != 200) {
        self$onResponseError(response, "storageInUse")
    } else {
        answer = content(response)[[1]]
    }
    return(answer)
}))
