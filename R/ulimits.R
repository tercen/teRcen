#' Ulimits
#'
#' @export
#' @format \code{\link{R6Class}} object.
#' @field core_file_size of type int.
#' @field data_seg_size of type int.
#' @field scheduling_priority of type int.
#' @field file_size of type int.
#' @field pending_signals of type int.
#' @field max_locked_memory of type int.
#' @field max_memory_size of type int.
#' @field open_files of type int.
#' @field pipe_size of type int.
#' @field message_queues of type int.
#' @field real_time_priority of type int.
#' @field stack_size of type int.
#' @field cpu_time of type int.
#' @field max_user_processes of type int.
#' @field virtual_memory of type int.
#' @field file_locks of type int.
Ulimits <- R6::R6Class("Ulimits", inherit = Base, public = list(core_file_size = NULL, 
    data_seg_size = NULL, scheduling_priority = NULL, file_size = NULL, pending_signals = NULL, 
    max_locked_memory = NULL, max_memory_size = NULL, open_files = NULL, pipe_size = NULL, 
    message_queues = NULL, real_time_priority = NULL, stack_size = NULL, cpu_time = NULL, 
    max_user_processes = NULL, virtual_memory = NULL, file_locks = NULL, initialize = function(json = NULL) {
        if (!is.null(json)) {
            self$initJson(json)
        } else {
            self$init()
        }
    }, init = function() {
        super$init()
        self$core_file_size = 0
        self$data_seg_size = 0
        self$scheduling_priority = 0
        self$file_size = 0
        self$pending_signals = 0
        self$max_locked_memory = 0
        self$max_memory_size = 0
        self$open_files = 0
        self$pipe_size = 0
        self$message_queues = 0
        self$real_time_priority = 0
        self$stack_size = 0
        self$cpu_time = 0
        self$max_user_processes = 0
        self$virtual_memory = 0
        self$file_locks = 0
    }, initJson = function(json) {
        super$initJson(json)
        self$core_file_size = json$core_file_size
        self$data_seg_size = json$data_seg_size
        self$scheduling_priority = json$scheduling_priority
        self$file_size = json$file_size
        self$pending_signals = json$pending_signals
        self$max_locked_memory = json$max_locked_memory
        self$max_memory_size = json$max_memory_size
        self$open_files = json$open_files
        self$pipe_size = json$pipe_size
        self$message_queues = json$message_queues
        self$real_time_priority = json$real_time_priority
        self$stack_size = json$stack_size
        self$cpu_time = json$cpu_time
        self$max_user_processes = json$max_user_processes
        self$virtual_memory = json$virtual_memory
        self$file_locks = json$file_locks
    }, toTson = function() {
        m = super$toTson()
        m$kind = tson.scalar("Ulimits")
        m$core_file_size = tson.int(self$core_file_size)
        m$data_seg_size = tson.int(self$data_seg_size)
        m$scheduling_priority = tson.int(self$scheduling_priority)
        m$file_size = tson.int(self$file_size)
        m$pending_signals = tson.int(self$pending_signals)
        m$max_locked_memory = tson.int(self$max_locked_memory)
        m$max_memory_size = tson.int(self$max_memory_size)
        m$open_files = tson.int(self$open_files)
        m$pipe_size = tson.int(self$pipe_size)
        m$message_queues = tson.int(self$message_queues)
        m$real_time_priority = tson.int(self$real_time_priority)
        m$stack_size = tson.int(self$stack_size)
        m$cpu_time = tson.int(self$cpu_time)
        m$max_user_processes = tson.int(self$max_user_processes)
        m$virtual_memory = tson.int(self$virtual_memory)
        m$file_locks = tson.int(self$file_locks)
        return(m)
    }, print = function(...) {
        cat(yaml::as.yaml(self$toTson()))
        invisible(self)
    }))
