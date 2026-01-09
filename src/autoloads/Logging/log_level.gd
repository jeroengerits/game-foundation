extends RefCounted
class_name LogLevel

## Log level enumeration
## Lower numbers = more critical, higher numbers = more verbose
## Filtering: Logs are shown if level <= min_log_level
enum LogLevel {
	NONE = 0,     ## Disables all logging
	ERROR = 1,    ## Error messages (uses push_error)
	WARNING = 2,  ## Warning messages (uses push_warning)
	INFO = 3,     ## General information messages
	DEBUG = 4     ## Detailed debugging information
}
