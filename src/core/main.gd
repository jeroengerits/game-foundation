## Main scene script
##
## Application entry point. Initializes the Application on ready.
extends Application

func _ready() -> void:
	if not initialize():
		push_error("Main: Failed to initialize application")
		get_tree().quit()
