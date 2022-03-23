library(tercen)
library(tercenApi)
library(dplyr)

options("tercen.serviceUri"= "http://127.0.0.1:5400/api/v1")
options("tercen.username"= "admin")
options("tercen.password"= "admin")
getOption("tercen.serviceUri")
getOption("tercen.username")
getOption("tercen.password")
 
# http://127.0.0.1:5400/alex/w/e253a390e03810cea5eaaed98801e9f0/ds/e2212192-a0c8-44b5-9a82-1bd56bc4daae
options("tercen.workflowId"= "e253a390e03810cea5eaaed98801e9f0")
options("tercen.stepId"= "e2212192-a0c8-44b5-9a82-1bd56bc4daae")
getOption("tercen.workflowId")
getOption("tercen.stepId")
 
ctx = tercenCtx()
ctx$names 

ctx %>% as.matrix()


ctx %>% select()
tercenCtx()$query
tercenCtx()$select()
tercenCtx()$rschema
tercenCtx()$cschema
tercenCtx()$rrelation
tercenCtx()$crelation
tercenCtx()$workflow

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

      