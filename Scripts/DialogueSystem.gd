# DialogueSystem.gd
extends Node
class_name DialogueSystem


var dialogue_data: Dictionary = {}
#var current_node_id: String = ""
var _next_node_id: String = ""
var current_node_ids := {
	0: "start",  # player 1
	1: "start"   # player 2
}
var waiting_for_sync: bool = false
var confirmed_players: Dictionary = {}
signal node_loaded(node_id)
signal trigger_fired(trigger_name)

# Player UI node references (assign in editor or code)
@export_node_path var player_ui_1_path: NodePath = "../PlayerUIPanel"
@export_node_path var player_ui_2_path: NodePath = "../PlayerUIPanel2"
@onready var player_ui_1 = get_node(player_ui_1_path)
@onready var player_ui_2 = get_node(player_ui_2_path)
@export var trigger_dispatcher_path: NodePath = "../DialogueSystem/TriggerDispatcher"
@onready var trigger_dispatcher = get_node(trigger_dispatcher_path)

func _ready():
	print("🧠 Trigger Dispatcher node?", trigger_dispatcher)
	trigger_dispatcher.player_ui_1 = player_ui_1
	trigger_dispatcher.player_ui_2 = player_ui_2

	load_dialogue("res://Dialogue/sample_narrative.json")
	#call_deferred("load_node", "start")
	call_deferred("load_node", "start", 0)
	call_deferred("load_node", "start", 1)
	# Connect player UI signals
	#player_ui_1.continue_requested.connect(_on_continue_requested.bind(0))
	#player_ui_2.continue_requested.connect(_on_continue_requested.bind(1))
	player_ui_1.choice_selected.connect(_on_choice_selected)
	player_ui_2.choice_selected.connect(_on_choice_selected)

#func _on_continue_requested(player_id: int):
	#if waiting_for_sync:
		#confirmed_players[player_id] = true
		#if confirmed_players.size() == 2:
			#waiting_for_sync = false
			#load_node(_next_node_id, player_id)
	#else:
		#load_node(_next_node_id, player_id)

func _on_choice_selected(next_node_id: String, player_id: int, triggers: Array):
	#var node = dialogue_data.get(next_node_id, {})
	
	load_node(next_node_id, player_id)
	print("📥 Player", player_id, "chose", next_node_id)
	
	for trigger in triggers:
		print("📦 Dispatching trigger from choice:", trigger)
		trigger_dispatcher.dispatch(trigger, player_id)
		
		
	
	
func load_dialogue(json_path: String):
	var file = FileAccess.open(json_path, FileAccess.READ)
	dialogue_data = JSON.parse_string(file.get_as_text())
	file.close()

func load_node(node_id: String, player_id: int):
	
	if player_id != -1:
		current_node_ids[player_id] = node_id

	var node = dialogue_data.get(node_id, {})
	
	
	# Apply content per player
	if player_id == 0 or player_id == -1:
		player_ui_1.set_current_text(node.get("text_p1", ""))
		player_ui_1.show_choices(node.get("choices_p1", []))
		player_ui_1.set_waiting_for_sync(node.get("sync_point", false))
	
	if player_id == 1 or player_id == -1:
		player_ui_2.set_current_text(node.get("text_p2", ""))
		player_ui_2.show_choices(node.get("choices_p2", []))
		player_ui_2.set_waiting_for_sync(node.get("sync_point", false))
	
	# Store fallback "next" if applicable
	_next_node_id = node.get("next", "")
	
	## Text lines
	#player_ui_1.set_current_text(node.get("text_p1", ""))
	#player_ui_2.set_current_text(node.get("text_p2", ""))
#
	## Choices
	#player_ui_1.show_choices(node.get("choices_p1", []))
	#player_ui_2.show_choices(node.get("choices_p2", []))
	
	var sync = node.get("sync_point", false)
	waiting_for_sync = sync
	confirmed_players.clear()
	player_ui_1.set_waiting_for_sync(sync)
	player_ui_2.set_waiting_for_sync(sync)
	
	# Triggers
	for trigger in node.get("triggers", []):
		print(trigger)
		trigger_dispatcher.dispatch(trigger)
		emit_signal("trigger_fired", trigger)

	emit_signal("node_loaded", node_id)
