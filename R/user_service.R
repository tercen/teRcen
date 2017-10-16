UserService <- R6::R6Class("UserService", inherit = HttpClientService, public = list(initialize = function(baseRestUri, 
    client) {
    super$initialize(baseRestUri, client)
    self$uri = "api/v1/user"
}, findUserByCreatedDateAndName = function(startKey = NULL, endKey = NULL, limit = 20, 
    skip = 0, descending = TRUE, useFactory = FALSE) {
    return(self$findStartKeys("findUserByCreatedDateAndName", startKey = startKey, 
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
    uri = paste0("api/v1/user", "/", "connect")
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
    uri = paste0("api/v1/user", "/", "createUser")
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
}, updatePassword = function(userId, password) {
    answer = NULL
    response = NULL
    uri = paste0("api/v1/user", "/", "updatePassword")
    params = list()
    params[["userId"]] = unbox(userId)
    params[["password"]] = unbox(password)
    url = self$getServiceUri(uri)
    response = self$client$post(url, body = params)
    if (status_code(response) != 200) {
        self$onResponseError(response, "updatePassword")
    } else {
        answer = NULL
    }
    return(answer)
}, summary = function(userId) {
    answer = NULL
    response = NULL
    uri = paste0("api/v1/user", "/", "summary")
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
    uri = paste0("api/v1/user", "/", "resourceSummary")
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
    uri = paste0("api/v1/user", "/", "profiles")
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
    uri = paste0("api/v1/user", "/", "createToken")
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
}, isTokenValid = function(token) {
    answer = NULL
    response = NULL
    uri = paste0("api/v1/user", "/", "isTokenValid")
    params = list()
    params[["token"]] = unbox(token)
    url = self$getServiceUri(uri)
    response = self$client$post(url, body = params)
    if (status_code(response) != 200) {
        self$onResponseError(response, "isTokenValid")
    } else {
        answer = content(response)[[1]]
    }
    return(answer)
}, setTeamPrivilege = function(username, principal, privilege) {
    answer = NULL
    response = NULL
    uri = paste0("api/v1/user", "/", "setTeamPrivilege")
    params = list()
    params[["username"]] = unbox(username)
    params[["principal"]] = principal$toTson()
    params[["privilege"]] = privilege$toTson()
    url = self$getServiceUri(uri)
    response = self$client$post(url, body = params)
    if (status_code(response) != 200) {
        self$onResponseError(response, "setTeamPrivilege")
    } else {
        answer = content(response)[[1]]
    }
    return(answer)
}, getServerVersion = function(module) {
    answer = NULL
    response = NULL
    uri = paste0("api/v1/user", "/", "getServerVersion")
    params = list()
    params[["module"]] = unbox(module)
    url = self$getServiceUri(uri)
    response = self$client$post(url, body = params)
    if (status_code(response) != 200) {
        self$onResponseError(response, "getServerVersion")
    } else {
        answer = createObjectFromJson(content(response))
    }
    return(answer)
}))
