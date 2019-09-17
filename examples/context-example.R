library(tercen)
library(dplyr)

getOption("tercen.serviceUri")
getOption("tercen.username")
getOption("tercen.password")
 
# http://127.0.0.1:5400/core/#ds/3aa8703da6b7534488c2f9632a0c0b0d/3-2
options("tercen.workflowId"= "3aa8703da6b7534488c2f9632a0c0b0d")
options("tercen.stepId"= "5-4")
getOption("tercen.workflowId")
getOption("tercen.stepId")
 
ctx = tercenCtx()
ctx$names 

ctx %>% as.matrix()
 

(ctx = tercenCtx()) %>% select()
tercenCtx()$query
tercenCtx()$select()
tercenCtx()$rschema
tercenCtx()$cschema
tercenCtx()$workflow
tercenCtx()$workflow

ctx = tercenCtx()

rbenchmark::benchmark(
"workflow"= {
  ctx$workflow
}, 
"select"= {
  ctx$select(c(".y", ".ri", ".ci"))
}, 
"as.matrix"= {
  ctx$as.matrix()
}, 
replications = 10,
columns = c("test", "replications", "elapsed",
            "relative", "user.self", "sys.self"))


ctx %>% select()
ctx %>% cselect()
ctx = tercenCtx()

ctx

ctx$namespace
ctx$query
ctx$yAxis
ctx$xAxis
ctx$colors
ctx$labels
ctx$errors

ctx$op.value('scale')

# columns names of the xy table
ctx$names
# columns names of the column table
ctx$cnames
# columns names of the row table
ctx$rnames

# schema of the xy table
ctx$schema
# schema of the column table
ctx$cschema
# schema of the row table
ctx$rschema

# select xy table
ctx$select()
ctx$select(nr=1)
ctx$select(offset=10L, nr=3L)
ctx$select(c('.y','.ci','.ri'), nr=3)
ctx$select('.y', nr=3)

# select column table
ctx$cselect()
# select row table
ctx$rselect()

ctx %>% select()
ctx %>% cselect()
ctx %>% rselect()
 
      