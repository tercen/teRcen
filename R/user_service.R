UserService <- R6::R6Class("UserService", inherit = HttpClientService, public = list(initialize = function(baseRestUri, 
    client) {
    super$initialize(baseRestUri, client)
    self$uri = "user"
}, findUserByNameByLastModifiedDate = function(startKey = NULL, endKey = NULL, limit = 20, 
    skip = 0, descending = TRUE, useFactory = FALSE) {
    return(self$findStartKeys("findUserByNameByLastModifiedDate", startKey = startKey, 
        endKey = endKey, limit = limit, skip = skip, descending = descending, useFactory = useFactory))
}, findUserByName = function(keys = NULL, useFactory = FALSE) {
    return(self$findKeys("userByName", keys = keys, useFactory = useFactory))
}, findUserByEmail = function(keys = NULL, useFactory = FALSE) {
    return(self$findKeys("userByEmail", keys = keys, useFactory = useFactory))
}, findTeamMembers = function(keys = NULL, useFactory = FALSE) {
    return(self$findKeys("teamMembers", keys = keys, useFactory = useFactory))
}, connect = function(usernameOrEmail, password) {
    answer = NULL
    response = NULL
    uri = paste0("user", "/", "connect")
    params = list()
    params[["usernameOrEmail"]] = unbox(usernameOrEmail)
    params[["password"]] = unbox(password)
    url = self$getServiceUri(uri)
    response = self$client$post(url, body = params)
    if (status_code(response) != 200) {
        self$onResponseError(response, "connect")
    } else {
        answer = createObjectFromJson(content(response))
    }
    return(answer)
}, createUser = function(user, password) {
    answer = NULL
    response = NULL
    uri = paste0("user", "/", "createUser")
    params = list()
    params[["user"]] = user$toTson()
    params[["password"]] = unbox(password)
    url = self$getServiceUri(uri)
    response = self$client$post(url, body = params)
    if (status_code(response) != 200) {
        self$onResponseError(response, "createUser")
    } else {
        answer = createObjectFromJson(content(response))
    }
    return(answer)
}, summary = function(userId) {
    answer = NULL
    response = NULL
    uri = paste0("user", "/", "summary")
    params = list()
    params[["userId"]] = unbox(userId)
    url = self$getServiceUri(uri)
    response = self$client$post(url, body = params)
    if (status_code(response) != 200) {
        self$onResponseError(response, "summary")
    } else {
        answer = createObjectFromJson(content(response))
    }
    return(answer)
}, resourceSummary = function(userId) {
    answer = NULL
    response = NULL
    uri = paste0("user", "/", "resourceSummary")
    params = list()
    params[["userId"]] = unbox(userId)
    url = self$getServiceUri(uri)
    response = self$client$post(url, body = params)
    if (status_code(response) != 200) {
        self$onResponseError(response, "resourceSummary")
    } else {
        answer = createObjectFromJson(content(response))
    }
    return(answer)
}, profiles = function(userId) {
    answer = NULL
    response = NULL
    uri = paste0("user", "/", "profiles")
    params = list()
    params[["userId"]] = unbox(userId)
    url = self$getServiceUri(uri)
    response = self$client$post(url, body = params)
    if (status_code(response) != 200) {
        self$onResponseError(response, "profiles")
    } else {
        answer = createObjectFromJson(content(response))
    }
    return(answer)
}, createToken = function(userId, validityInSeconds) {
    answer = NULL
    response = NULL
    uri = paste0("user", "/", "createToken")
    params = list()
    params[["userId"]] = unbox(userId)
    params[["validityInSeconds"]] = unbox(validityInSeconds)
    url = self$getServiceUri(uri)
    response = self$client$post(url, body = params)
    if (status_code(response) != 200) {
        self$onResponseError(response, "createToken")
    } else {
        answer = content(response)[[1]]
    }
    return(answer)
}))
