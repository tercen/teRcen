ServiceFactory <- R6::R6Class("ServiceFactory", public = list(issueMessageService = NULL, 
    workerService = NULL, fileService = NULL, garbageCollectorService = NULL, lockService = NULL, 
    issueService = NULL, subscriptionPlanService = NULL, workerEndpointService = NULL, 
    persistentService = NULL, activityService = NULL, folderService = NULL, tableSchemaService = NULL, 
    taskService = NULL, userSecretService = NULL, eventService = NULL, workflowService = NULL, 
    userService = NULL, projectDocumentService = NULL, cranLibraryService = NULL, 
    teamService = NULL, projectService = NULL, documentService = NULL, operatorService = NULL, 
    initialize = function(baseRestUri) {
        client = AuthHttpClient$new()
        self$issueMessageService = IssueMessageService$new(baseRestUri, client)
        self$workerService = WorkerService$new(baseRestUri, client)
        self$fileService = FileService$new(baseRestUri, client)
        self$garbageCollectorService = GarbageCollectorService$new(baseRestUri, client)
        self$lockService = LockService$new(baseRestUri, client)
        self$issueService = IssueService$new(baseRestUri, client)
        self$subscriptionPlanService = SubscriptionPlanService$new(baseRestUri, client)
        self$workerEndpointService = WorkerEndpointService$new(baseRestUri, client)
        self$persistentService = PersistentService$new(baseRestUri, client)
        self$activityService = ActivityService$new(baseRestUri, client)
        self$folderService = FolderService$new(baseRestUri, client)
        self$tableSchemaService = TableSchemaService$new(baseRestUri, client)
        self$taskService = TaskService$new(baseRestUri, client)
        self$userSecretService = UserSecretService$new(baseRestUri, client)
        self$eventService = EventService$new(baseRestUri, client)
        self$workflowService = WorkflowService$new(baseRestUri, client)
        self$userService = UserService$new(baseRestUri, client)
        self$projectDocumentService = ProjectDocumentService$new(baseRestUri, client)
        self$cranLibraryService = CranLibraryService$new(baseRestUri, client)
        self$teamService = TeamService$new(baseRestUri, client)
        self$projectService = ProjectService$new(baseRestUri, client)
        self$documentService = DocumentService$new(baseRestUri, client)
        self$operatorService = OperatorService$new(baseRestUri, client)
    }))
