library(R6)
library(tercenApi)

#' @import R6 tercenApi  
#' @export
TercenClient <- R6Class("TercenClient", inherit = ServiceFactory, public = list(session = NULL, 
    initialize = function(username = getOption("tercen.username"), password = getOption("tercen.password"), 
                          authToken = NULL, serviceUri = getOption("tercen.serviceUri", default = "https://tercen.com/api/v1/")) {
      argsMap = parseCommandArgs()
      if (!is.null(argsMap$serviceUri)) {
        super$initialize(argsMap$serviceUri, AuthHttpClient$new())
      } else {
        super$initialize(serviceUri, AuthHttpClient$new())
      }
      token = argsMap$token
      if (is.null(token)) {
        token = authToken
      }
      if (is.null(token)) {
        if (is.null(username) || is.null(password)) stop("token or username and password are required")
        self$session = self$userService$connect(username, password)
        self$userService$client$token = self$session$token$token
      } else {
        self$userService$client$token = token
      }
    }))