extends Node

## Logging service singleton
## 
## Provides centralized logging with configurable log levels and context tags.
## Simple, focused implementation - logs directly to console.
## Autoload name: Logger
## 
## CRITICAL: This service must be initialized FIRST in autoload order.
## Other autoloads may depend on Logger being available during their initialization.
## See project.godot [autoload] section - Logger must be listed first.
## 
## Usage:
##   Logger.debug("Player position: %s" % position)
##   Logger.info("Game started", "Main")
##   Logger.warning("Low health: %d" % health)
##   Logger.error("Failed to load resource", "ResourceLoader")

## Minimum log level to output
## 
## Controls which log levels are displayed. Logs with level <= min_log_level are shown.
## Lower numbers = more critical, higher numbers = more verbose.
## 
## Default: DEBUG (4) for development
## Set to NONE (0) to disable all logging, or ERROR (1) for production
@export var min_log_level: LogLevel.LogLevel = LogLevel.LogLevel.DEBUG

## Array of log level names for formatting
const LOG_LEVEL_NAMES: Array[String] = ["NONE", "ERROR", "WARNING", "INFO", "DEBUG"]

## Log a debug message
## 
## @param message: The message to log
## @param context: Optional context tag for filtering (e.g., "Inventory", "Network")
func debug(message: String, context: String = "") -> void:
	_log(LogLevel.LogLevel.DEBUG, message, context)

## Log an info message
## 
## @param message: The message to log
## @param context: Optional context tag for filtering (e.g., "Inventory", "Network")
func info(message: String, context: String = "") -> void:
	_log(LogLevel.LogLevel.INFO, message, context)

## Log a warning message
## Uses Godot's push_warning() for proper warning handling
## 
## @param message: The message to log
## @param context: Optional context tag for filtering (e.g., "Inventory", "Network")
func warning(message: String, context: String = "") -> void:
	_log(LogLevel.LogLevel.WARNING, message, context)

## Log an error message
## Uses Godot's push_error() for proper error handling
## 
## @param message: The message to log
## @param context: Optional context tag for filtering (e.g., "ResourceLoader")
func error(message: String, context: String = "") -> void:
	_log(LogLevel.LogLevel.ERROR, message, context)

## Core logging method
## Formats and outputs log messages based on level
## 
## Filtering: Logs are shown if level <= min_log_level (lower = more critical).
## If min_log_level is NONE (0), all logging is disabled.
## 
## @param level: The log level (NONE=0, ERROR=1, WARNING=2, INFO=3, DEBUG=4)
## @param message: The message to log
## @param context: Optional context tag for filtering (e.g., "Container", "Config")
func _log(level: LogLevel.LogLevel, message: String, context: String = "") -> void:
	# Early return if logging is disabled or level is too verbose
	if min_log_level == LogLevel.LogLevel.NONE or level > min_log_level:
		return
	
	# Format message: "LEVEL [Context]: message"
	var level_name: String = LOG_LEVEL_NAMES[level]
	var context_tag: String = " [%s]" % context if not context.is_empty() else ""
	var formatted: String = "%s%s: %s" % [level_name, context_tag, message]
	
	match level:
		LogLevel.LogLevel.DEBUG, LogLevel.LogLevel.INFO:
			print(formatted)
		LogLevel.LogLevel.WARNING:
			push_warning(formatted)
		LogLevel.LogLevel.ERROR:
			push_error(formatted)
