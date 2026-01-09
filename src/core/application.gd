## Application class
## 
## Main application controller responsible for bootstrapping and lifecycle management.
## Handles initialization, scene routing, and graceful shutdown.
##
## Dependencies:
## - None (acts as root bootstrap)
## - Other systems should depend on Application, not vice versa
class_name Application
extends Node

## Application state enum
enum State {
	UNINITIALIZED,
	INITIALIZING,
	RUNNING,
	STOPPING
}

## Signal emitted when application initialization completes
signal initialized()

## Signal emitted when application shutdown begins
signal shutting()

## Signal emitted when application shutdown completes
signal stopped()

## Current state of the application
var _state: State = State.UNINITIALIZED

## Initialize the application
## 
## Returns: true if initialization succeeds, false otherwise
func initialize() -> bool:
	if _state != State.UNINITIALIZED:
		push_error("Application: Cannot initialize - already in state: " + State.keys()[_state])
		return false
	
	_state = State.INITIALIZING
	
	if not _setup():
		_state = State.UNINITIALIZED
		return false
	
	_state = State.RUNNING
	initialized.emit()
	return true

## Shutdown the application gracefully
##
## Returns: true if shutdown succeeds, false otherwise
func shutdown() -> bool:
	if _state == State.UNINITIALIZED:
		push_error("Application: Cannot shutdown - not initialized")
		return false
	
	if _state == State.STOPPING:
		push_warning("Application: Shutdown already in progress")
		return false
	
	_state = State.STOPPING
	shutting.emit()
	
	if not _teardown():
		_state = State.RUNNING
		return false
	
	_state = State.UNINITIALIZED
	stopped.emit()
	return true

## Get current application state
func state() -> State:
	return _state

## Check if application is in running state
func running() -> bool:
	return _state == State.RUNNING

# Private methods

func _setup() -> bool:
	# Placeholder for application-specific setup
	# Override or extend as needed
	return true

func _teardown() -> bool:
	# Placeholder for application-specific teardown
	# Override or extend as needed
	return true

func _notification(what: int) -> void:
	match what:
		NOTIFICATION_WM_CLOSE_REQUEST:
			if running():
				shutdown()
				get_tree().quit()
		NOTIFICATION_APPLICATION_FOCUS_OUT:
			# Handle application focus loss if needed
			pass
		NOTIFICATION_APPLICATION_FOCUS_IN:
			# Handle application focus gain if needed
			pass
