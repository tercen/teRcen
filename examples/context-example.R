library(tercen)
library(dplyr)

getOption("tercen.serviceUri")
getOption("tercen.username")
getOption("tercen.password")
 
options("tercen.workflowId"= "89295163a4460e6423fe002f813ad971")
options("tercen.stepId"= "3-1")
getOption("tercen.workflowId")
getOption("tercen.stepId")

(ctx = tercenCtx()) %>% select()
ctx %>% cselect()
ctx = tercenCtx()

ctx$namespace
ctx$query
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
ctx$select(offset=10, nr=3)
ctx$select(c('.y','.ci','.ri'), nr=3)
ctx$select('.y', nr=3)

# select column table
ctx$cselect()
# select row table
ctx$rselect()

ctx %>% select()
ctx %>% cselect()
ctx %>% rselect()
      