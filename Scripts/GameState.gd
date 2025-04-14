# GameState.gd
extends Node

# Singleton player data structure
var player_data := {
	0: { "inventory": [], "choices": [], "location": "start" },
	1: { "inventory": [], "choices": [], "location": "start" }
}

# Global game flags / world state
var global_flags := {
	"sync_locked": false,
	"map_opened": false
}

# Called at runtime to reset
func reset():
	player_data = {
		0: { "inventory": [], "choices": [], "location": "start" },
		1: { "inventory": [], "choices": [], "location": "start" }
	}
	global_flags = {
		"sync_locked": false,
		"map_opened": false
	}

# Add a choice to a player
func add_choice(player_id: int, choice_id: String):
	if not player_data[player_id]["choices"].has(choice_id):
		player_data[player_id]["choices"].append(choice_id)

# Check if a player made a specific choice
func has_choice(player_id: int, choice_id: String) -> bool:
	return player_data[player_id]["choices"].has(choice_id)

# Set a global flag
func set_flag(flag: String, value: bool):
	global_flags[flag] = value

# Get a global flag
func get_flag(flag: String) -> bool:
	return global_flags.get(flag, false)
