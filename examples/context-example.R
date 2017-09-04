library(tercen)
library(dplyr)

getOption("tercen.serviceUri")
getOption("tercen.username")
getOption("tercen.password")
getOption("tercen.workflowId")
getOption("tercen.stepId")

ctx = tercenCtx()
ctx$names
ctx$namespace
ctx$query
ctx$schema
ctx$select()
ctx$select(nr=1)
ctx$select(offset=10, nr=3)
ctx$select(c('.values','.cindex','.rindex'), nr=3)
ctx$select('.values', nr=3)
   
