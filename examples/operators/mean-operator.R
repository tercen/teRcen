library(tercen)
library(dplyr)

getOption("tercen.serviceUri")
getOption("tercen.username")
getOption("tercen.password")
   
# http://127.0.0.1:5400/core/#ds/3aa8703da6b7534488c2f9632a0c0b0d/3-2
options("tercen.workflowId"= "3aa8703da6b7534488c2f9632a0c0b0d")
options("tercen.stepId"= "21-7")
getOption("tercen.workflowId")
getOption("tercen.stepId")
 
(ctx = tercenCtx())  %>% 
  select(.y, .ci, .ri) %>% 
  group_by(.ci, .ri) %>%
  summarise(mean = mean(.y)) %>%
  ctx$addNamespace() %>%
  ctx$save()
 

tercenCtx()$query
 