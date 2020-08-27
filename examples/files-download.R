library(tercen)
library(dplyr)
 

# http://localhost:53322/index.html#/alex/w/e11cea9d1119c8e6dbb0842925032c6e/ds/91c7e052-54e6-49b8-bf2c-09f55c5762e3
options("tercen.serviceUri"="http://172.17.0.1:5400/api/v1/")
options("tercen.workflowId"= "e11cea9d1119c8e6dbb0842925032c6e")
options("tercen.stepId"= "91c7e052-54e6-49b8-bf2c-09f55c5762e3")
options("tercen.username"="admin")
options("tercen.password"="admin")

ctx = tercenCtx()

textFile = '0821a45e1447ffa25d69ef55d808234c'

ctx$client$fileService$get(textFile)
bytes = ctx$client$fileService$download(textFile)
length(bytes)
