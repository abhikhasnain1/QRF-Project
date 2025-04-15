# TriggerDispatcher.gd
extends Node
class_name TriggerDispatcher

var player_ui_1: Node
var player_ui_2: Node

func dispatch(trigger_name: String, player_id : int):
	print("🔌 Player panels available?", player_ui_1 != null, player_ui_2 != null)
	print("🎯 Trigger received:", trigger_name, "from Player", player_id)
	if trigger_name.begins_with("lock_out_choice"):
		print(trigger_name)
		var choice_id = trigger_name.get_slice(":", 1)
		print("This is the trigger: ", choice_id)
		if player_id == 0:
			var target_panel = player_ui_2
			print("The player is ", player_id, "and their panel is ", target_panel)
			target_panel.remove_choice(choice_id)
		else:
			print(trigger_name)
			var target_panel = player_ui_1
			print("The player is ", player_id, "and their panel is ", target_panel)
			target_panel.remove_choice(choice_id)
	#match trigger_name:
		#
		#"reveal_map":
			#_show_shared_ui("MapButton")
		#"open_inventory":
			#_show_shared_ui("InventoryButton")
		#"give_item_sword":
			#GameState.player_data[player_id]["inventory"].append("sword")
		#"unlock_gate":
			#GameState.set_flag("gate_unlocked", true)
		#_:
			#print("Unhandled trigger: ", trigger_name)

func _show_shared_ui(button_name: String):
	var shared_ui = get_node("../SharedControlPanel")  # adjust if needed
	var btn = shared_ui.get_node_or_null(button_name)
	if btn:
		btn.visible = true
		btn.modulate.a = 1.0
		btn.play("reveal") if btn.has_method("play") else null
