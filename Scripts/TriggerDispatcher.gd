# TriggerDispatcher.gd
extends Node
class_name TriggerDispatcher

func dispatch(trigger_name: String, player_id := -1):
	match trigger_name:
		"reveal_map":
			_show_shared_ui("MapButton")
		"open_inventory":
			_show_shared_ui("InventoryButton")
		"give_item_sword":
			GameState.player_data[player_id]["inventory"].append("sword")
		"unlock_gate":
			GameState.set_flag("gate_unlocked", true)
		_:
			print("Unhandled trigger: ", trigger_name)

func _show_shared_ui(button_name: String):
	var shared_ui = get_node("../SharedControlPanel")  # adjust if needed
	var btn = shared_ui.get_node_or_null(button_name)
	if btn:
		btn.visible = true
		btn.modulate.a = 1.0
		btn.play("reveal") if btn.has_method("play") else null
