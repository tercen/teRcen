ServiceFactory <- R6::R6Class("ServiceFactory", public = list(tableSchemaService = NULL, 
    taskService = NULL, workerService = NULL, userSecretService = NULL, fileService = NULL, 
    workflowService = NULL, userService = NULL, projectDocumentService = NULL, teamService = NULL, 
    documentService = NULL, operatorService = NULL, projectService = NULL, initialize = function(baseRestUri) {
        client = AuthHttpClient$new()
        self$tableSchemaService = TableSchemaService$new(baseRestUri, client)
        self$taskService = TaskService$new(baseRestUri, client)
        self$workerService = WorkerService$new(baseRestUri, client)
        self$userSecretService = UserSecretService$new(baseRestUri, client)
        self$fileService = FileService$new(baseRestUri, client)
        self$workflowService = WorkflowService$new(baseRestUri, client)
        self$userService = UserService$new(baseRestUri, client)
        self$projectDocumentService = ProjectDocumentService$new(baseRestUri, client)
        self$teamService = TeamService$new(baseRestUri, client)
        self$documentService = DocumentService$new(baseRestUri, client)
        self$operatorService = OperatorService$new(baseRestUri, client)
        self$projectService = ProjectService$new(baseRestUri, client)
    }))
