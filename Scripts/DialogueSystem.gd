# DialogueSystem.gd
extends Node
class_name DialogueSystem

var dialogue_data: Dictionary = {}
var current_node_id: String = "start"

signal node_loaded(node_id)
signal trigger_fired(trigger_name)

# Player UI node references (assign in editor or code)
@export_node_path var player_ui_1_path: NodePath
@export_node_path var player_ui_2_path: NodePath
@onready var player_ui_1 = get_node(player_ui_1_path)
@onready var player_ui_2 = get_node(player_ui_2_path)
@export var trigger_dispatcher_path: NodePath
@onready var trigger_dispatcher = get_node(trigger_dispatcher_path)

func _ready():
	load_dialogue("res://dialogue/sample_narrative.json")
	load_node("start")

func load_dialogue(json_path: String):
	var file = FileAccess.open(json_path, FileAccess.READ)
	dialogue_data = JSON.parse_string(file.get_as_text())
	file.close()

func load_node(node_id: String):
	if not dialogue_data.has(node_id):
		push_error("Dialogue node not found: " + node_id)
		return
	
	current_node_id = node_id
	var node = dialogue_data[node_id]
	
	# Text lines
	player_ui_1.set_current_text(node.get("text_p1", ""))
	player_ui_2.set_current_text(node.get("text_p2", ""))

	# Choices
	player_ui_1.show_choices(node.get("choices_p1", []))
	player_ui_2.show_choices(node.get("choices_p2", []))

	# Triggers
	for trigger in node.get("triggers", []):
		trigger_dispatcher.dispatch(trigger)
		emit_signal("trigger_fired", trigger)

	emit_signal("node_loaded", node_id)
