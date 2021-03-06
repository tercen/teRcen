library(tercen)
library(openssl)
 
 
serviceUri="http://127.0.0.1:5400/api/v1/"
# serviceUri="http://172.17.0.1:5400/api/v1/"
username="admin"
password="admin"

filename = '~/projects/fcs_data/debarcoded.zip'
# filename = '~/projects/fcs_data/debarcoded.csv'
teamName = 'test-team'
projectName = 'project'
 
client = TercenClient$new(serviceUri=serviceUri,
                          username=username,
                          password=password)

client$session
  
projects = client$documentService$findProjectByOwnersAndCreatedDate(
  startKey=list(teamName,'2020'),
  endKey=list(teamName,''))
 
project = Find(function(p) identical(p$name,projectName), projects)
project
    
bytes = memCompress(readBin(file(filename, 'rb'), 
                            raw(), 
                            n=file.info(filename)$size),
                    type = 'gzip')
 
fileDoc = FileDocument$new()
fileDoc$name = 'atsne_data_analysis'
fileDoc$projectId = project$id
fileDoc$acl$owner = project$acl$owner
fileDoc$size = length(bytes)

# fileDoc$metadata = CSVFileMetadata$new()
fileDoc$metadata$md5Hash = toString(openssl::md5(bytes))
fileDoc$metadata$contentType = 'text/csv'
fileDoc$metadata$separator = ','
fileDoc$metadata$quote = '"'
fileDoc$metadata$contentEncoding = 'gzip,iso-8859-1'
fileDoc
      
fileDoc = client$fileService$upload(fileDoc, bytes)
fileDoc
ff = client$fileService$get(fileDoc$id)
class(ff)

task = CSVTask$new()
task$state = InitState$new()
task$fileDocumentId = fileDoc$id
task$owner = project$acl$owner
task$projectId = project$id

task = client$taskService$create(task)
client$taskService$runTask(task$id)
task = client$taskService$waitDone(task$id)
task
if (inherits(task$state, 'FailedState')){
  stop(task$state$reason)
}
# client$taskService$get(task$id)
 