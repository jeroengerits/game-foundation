extends RefCounted
class_name GameEvents

## Game Events
## 
## Contains all game-related signals.
## Loaded by Events to provide game event functionality.
## 
## Signals use snake_case naming convention as per architectural rules.

## Game started event
## Emitted when the game begins
signal game_started

## Game ended event
## Emitted when the game ends
signal game_ended
