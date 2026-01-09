extends Node

## Events
## 
## Simple event system for decoupled communication between systems.
## Uses signals for type-safe event handling.
## Creates game events from game_events.gd file.
## Autoload name: Events
## 
## Event Pattern: This service establishes the event pattern used across all services.
## Each service follows this same pattern by creating and managing its own domain-specific events:
##   - Events service → GameEvents (game_started, game_ended)
##   - Camera service → CameraEvents (move, zoom, rotate, yaw)
##   - Input service → InputEvents (key_pressed, mouse_moved, trackpad_zoom)
##   - Scene service → SceneEvents (loading_started, loaded, changed)
##   - Storage service → StorageEvents (save_started, save_completed, load_completed)
## 
## All services use the same pattern: ServiceName.events.signal_name.emit(...)
## 
## Usage:
##   Events.events.game_started.emit()
##   Events.events.game_started.connect(_on_game_started)
##   Camera.events.move.emit(Vector3(1, 0, 0))
##   Input.events.mouse_moved.connect(_on_mouse_moved)
## 
## Example:
##   func _ready() -> void:
##       Events.events.game_started.connect(_on_game_started)
##       Camera.events.move.connect(_on_camera_move)
##       Input.events.mouse_moved.connect(_on_mouse_moved)
##   
##   func _on_game_started() -> void:
##       Logger.info("Game started!", "Game")
##   
##   func _on_camera_move(direction: Vector3) -> void:
##       camera_position += direction
##   
##   func _on_mouse_moved(position: Vector2) -> void:
##       mouse_cursor = position

## Events instance containing all game-related signals
var events: GameEvents = GameEvents.new()
