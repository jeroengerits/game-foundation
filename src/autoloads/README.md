# Autoloads

Explicit singleton ownership. Singleton scripts registered in Project Settings.

## Rules

- Autoloads must be few, stable, and discoverable.
- Autoloads are allowed as composition roots / service locators, not gameplay logic buckets.
- Any global state must live here explicitly (no hidden globals elsewhere).

## Services

### Logger

**Location:** `src/autoloads/Logging/logger.gd`  
**Autoload Name:** `Logger`  
**Initialization Order:** Must be first (other autoloads may depend on it)

Centralized logging service with configurable log levels and context tags. Logs directly to console using Godot's built-in output methods.

#### Features

- **Log Levels:** DEBUG, INFO, WARNING, ERROR, NONE
- **Context Tags:** Optional context strings for filtering (e.g., "Inventory", "Network")
- **Configurable Filtering:** Set `min_log_level` to control verbosity
- **Proper Output:** Uses `print()`, `push_warning()`, and `push_error()` appropriately

#### Usage Examples

```gdscript
# Basic logging
Logger.debug("Player position: %s" % position)
Logger.info("Game started")
Logger.warning("Low health: %d" % health)
Logger.error("Failed to load resource")

# With context tags
Logger.info("Game started", "Main")
Logger.error("Failed to load resource", "ResourceLoader")
Logger.debug("Player position: %s" % position, "Player")
```

#### Configuration

```gdscript
# Set minimum log level (default: DEBUG)
Logger.min_log_level = LogLevel.LogLevel.INFO  # Only show INFO, WARNING, ERROR
Logger.min_log_level = LogLevel.LogLevel.ERROR  # Only show errors
Logger.min_log_level = LogLevel.LogLevel.NONE  # Disable all logging
```

#### Log Level Reference

| Level | Value | Description | Output Method |
|-------|-------|-------------|---------------|
| NONE | 0 | Disables all logging | - |
| ERROR | 1 | Error messages | `push_error()` |
| WARNING | 2 | Warning messages | `push_warning()` |
| INFO | 3 | General information | `print()` |
| DEBUG | 4 | Detailed debugging | `print()` |

**Filtering Logic:** Logs are shown if `level <= min_log_level` (lower numbers = more critical).

---

### Events

**Location:** `src/autoloads/Events/events.gd`  
**Autoload Name:** `Events`  
**Initialization Order:** After Logger

Event bus system for decoupled communication between systems using signals. Provides type-safe event handling through signal-based architecture.

#### Features

- **Signal-Based:** Uses Godot's native signal system
- **Type-Safe:** Events are defined as typed signal classes
- **Extensible:** Each service can define its own event classes
- **Decoupled:** Systems communicate without direct dependencies

#### Usage Examples

```gdscript
# Emit events
Events.events.game_started.emit()
Events.events.game_ended.emit()

# Connect to events
func _ready() -> void:
	Events.events.game_started.connect(_on_game_started)
	Events.events.game_ended.connect(_on_game_ended)

func _on_game_started() -> void:
	Logger.info("Game started!", "Game")

func _on_game_ended() -> void:
	Logger.info("Game ended!", "Game")
```

#### Event Pattern

This service establishes the event pattern used across all services. Each service follows the same pattern:

- **Events service** → `GameEvents` (game_started, game_ended)
- **Camera service** → `CameraEvents` (move, zoom, rotate, yaw)
- **Input service** → `InputEvents` (key_pressed, mouse_moved, trackpad_zoom)
- **Scene service** → `SceneEvents` (loading_started, loaded, changed)
- **Storage service** → `StorageEvents` (save_started, save_completed, load_completed)

**Pattern:** `ServiceName.events.signal_name.emit(...)`

#### Available Game Events

- `game_started` - Emitted when the game begins
- `game_ended` - Emitted when the game ends

#### Creating Custom Events

To add new game events, edit `src/autoloads/Events/game_events.gd`:

```gdscript
## New event signal
signal player_died
signal level_completed(level_id: int)
```

Then use it:
```gdscript
Events.events.player_died.emit()
Events.events.level_completed.emit(5)
```

---

## File Structure

```
src/autoloads/
├── Logging/
│   ├── logger.gd          # Logger autoload service
│   └── log_level.gd       # LogLevel enum class
├── Events/
│   ├── events.gd          # Events autoload service
│   └── game_events.gd     # GameEvents signal class
└── README.md              # This file
```
