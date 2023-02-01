library(httr)
library(rstudioapi)

#' @export
connect <- function (url, set_credentials = TRUE, serviceUri = NULL)  {
  parsed_url <- httr::parse_url(url)
  is_local <- parsed_url$hostname %in% c("127.0.0.1", "localhost")
  
  if (parsed_url$hostname == "tercen.com") {
    options(tercen.serviceUri = "https://tercen.com/api/v1/")
  } else if (is_local) {
    options(tercen.serviceUri = "http://tercen:5400/api/v1")
  } else if (is.null(serviceUri)) {
    options(tercen.serviceUri = paste0("https://", parsed_url$hostname, "/api/v1/"))
  } else {
    options(tercen.serviceUri = serviceUri)
  }
  
  splitted_url <- strsplit(parsed_url$path, "/")[[1]]
  workflowId <- splitted_url[which(splitted_url == "w") + 1]
  stepId <- splitted_url[which(splitted_url == "ds") + 1]
  
  if (any(is.na(c(workflowId, stepId)))) {
    stop("Invalid URL.")
  }
  
  options(tercen.workflowId = workflowId)
  options(tercen.stepId = stepId)

  if (set_credentials & !is_local) {
    set_tercen_credentials()
  } else {
    options(tercen.username = "admin")
    options(tercen.password = "admin")
  }
  
  return(NULL)
}

set_tercen_credentials <- function (force = FALSE) {
  username <- getOption("tercen.username")
  if (is.null(username) | username == "admin" | force) {
    options(tercen.username = rstudioapi::askForPassword("Tercen username"))
  }
  password <- getOption("tercen.password")
  if (is.null(password) | password == "admin" | force) {
    options(tercen.password = rstudioapi::askForPassword("Tercen password"))
  } 
  return(NULL)
}