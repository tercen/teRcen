ServiceFactory <- R6::R6Class("ServiceFactory", public = list(workerService = NULL, 
    garbageCollectorService = NULL, fileService = NULL, lockService = NULL, subscriptionPlanService = NULL, 
    workerEndpointService = NULL, persistentService = NULL, tableSchemaService = NULL, 
    taskService = NULL, eventService = NULL, userSecretService = NULL, workflowService = NULL, 
    userService = NULL, projectDocumentService = NULL, teamService = NULL, projectService = NULL, 
    documentService = NULL, operatorService = NULL, initialize = function(baseRestUri) {
        client = AuthHttpClient$new()
        self$workerService = WorkerService$new(baseRestUri, client)
        self$garbageCollectorService = GarbageCollectorService$new(baseRestUri, client)
        self$fileService = FileService$new(baseRestUri, client)
        self$lockService = LockService$new(baseRestUri, client)
        self$subscriptionPlanService = SubscriptionPlanService$new(baseRestUri, client)
        self$workerEndpointService = WorkerEndpointService$new(baseRestUri, client)
        self$persistentService = PersistentService$new(baseRestUri, client)
        self$tableSchemaService = TableSchemaService$new(baseRestUri, client)
        self$taskService = TaskService$new(baseRestUri, client)
        self$eventService = EventService$new(baseRestUri, client)
        self$userSecretService = UserSecretService$new(baseRestUri, client)
        self$workflowService = WorkflowService$new(baseRestUri, client)
        self$userService = UserService$new(baseRestUri, client)
        self$projectDocumentService = ProjectDocumentService$new(baseRestUri, client)
        self$teamService = TeamService$new(baseRestUri, client)
        self$projectService = ProjectService$new(baseRestUri, client)
        self$documentService = DocumentService$new(baseRestUri, client)
        self$operatorService = OperatorService$new(baseRestUri, client)
    }))
