library(tercen)
library(dplyr)

getOption("tercen.serviceUri")
getOption("tercen.username")
getOption("tercen.password")

options("tercen.workflowId"= "bbb78735166d6862b70afaaac9038c39")
options("tercen.stepId"= "36-13")
getOption("tercen.workflowId")
getOption("tercen.stepId")
 
(ctx = tercenCtx())  %>% 
  select(.y, .ci, .ri) %>% 
  group_by(.ci, .ri) %>%
  summarise(mean = mean(.y)) %>%
  ctx$addNamespace() %>%
  ctx$save()
 
 