library(tercen)
 
settings1 = list(serviceUri="https://dev.tercen.com/api/v1/",
                          username=getOption("dev.tercen.username"),
                          password=getOption("dev.tercen.password"),
                          teamName = 'ENP TercenWorkshop',
                          projectName = 'SCN2A-2'
                          )
############################################
settings2 = list(serviceUri="http://51.83.108.195/api/v1/",
                          username="admin",
                          password="admin",
                          teamName = 'test-team',
                          projectName = 'SCN2A-2'
)
 
############################################
client1 = TercenClient$new(serviceUri=settings1$serviceUri,
                          username=settings1$username,
                          password=settings1$password)

client1$session$serverVersion

projects = client1$documentService$findProjectByOwnersAndCreatedDate(
  startKey=list(settings1$teamName,'2020'),
  endKey=list(settings1$teamName,''))

project = Find(function(p) identical(p$name,settings1$projectName), projects)
project

tbl.schemas = client1$projectDocumentService$findSchemaByLastModifiedDate(
  startKey=list(project$id,'2020'),
  endKey=list(project$id,''),
  useFactory=TRUE, limit = 1000)

tbl.schemas = Filter(function(schema) {startsWith(schema$name, "d-1902241832")}, tbl.schemas)

# tbl.names = Map(function(schema) schema$name, tbl.schemas)
# tbl.names

all.tbl = dplyr::bind_rows(lapply(tbl.schemas,
                                  client1$tableSchemaService$selectSchema),
                    .id = NULL)

bytes = memCompress( teRcenHttp::toTSON(tercen::dataframe.as.table(all.tbl)$toTson()),
                    type = 'gzip')
# relase memory
all.tbl = NULL

client2 = TercenClient$new(serviceUri=settings2$serviceUri,
                           username=settings2$username,
                           password=settings2$password)
 
  
projects2 = client2$documentService$findProjectByOwnersAndCreatedDate(
  startKey=list(settings2$teamName,'2020'),
  endKey=list(settings2$teamName,''))

project2 = Find(function(p) identical(p$name,settings2$projectName), projects2)
 

fileDoc = FileDocument$new()
fileDoc$name = 'SCN2A-2'
fileDoc$projectId = project2$id
fileDoc$acl$owner = project2$acl$owner
fileDoc$metadata = FileMetadata$new()
fileDoc$metadata$md5Hash = toString(openssl::md5(bytes))
fileDoc$metadata$contentType = 'application/octet-stream'
fileDoc$metadata$contentEncoding = 'gzip'
fileDoc
 
fileDoc = client2$fileService$upload(fileDoc, bytes)
 
task = CSVTask$new()
task$state = InitState$new()
cpu = Pair$new()
cpu
cpu$key='cpu'
cpu$value='16'
task$environment = list(cpu)
task$fileDocumentId = fileDoc$id
task$owner = project2$acl$owner
task$projectId = project2$id

task = client2$taskService$create(task)
client2$taskService$runTask(task$id)
task = client2$taskService$waitDone(task$id)
task
if (inherits(task$state, 'FailedState')){
  stop(task$state$reason)
}
# client2$taskService$get(task$id)
# client2$taskService$delete(task$id, task$rev)
