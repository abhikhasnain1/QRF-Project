# PlayerUIPanel.gd
extends Control
class_name PlayerUIPanel

@export var player_id: int = 0
@export var choice_button_scene: PackedScene = preload("res://Scenes/ChoiceButton.tscn")

@onready var history_label = $VBoxContainer/ScrollContainer/RichTextLabel
@onready var current_label = $VBoxContainer/CurrentTextLabel
@onready var choice_container = $VBoxContainer/ChoiceContainer
@onready var continue_button = $VBoxContainer/MarginContainer/ContinueButton
@onready var waiting_label = $VBoxContainer/WaitingLabel

signal continue_requested
signal choice_selected(next_node_id: String, player_id: int)

func _ready():
	
	continue_button.pressed.connect(_on_continue_pressed)
	waiting_label.visible = false

func set_current_text(new_text: String) -> void:
	# Append previous paragraph to history, then set new
	if current_label.text.strip_edges() != "":
		history_label.append_text("\n" + current_label.text)
		history_label.scroll_to_line(history_label.get_line_count() - 1)
	current_label.text = new_text

func show_choices(choices: Array) -> void:
	clear_buttons()

	if choices.is_empty():
		continue_button.visible = true
	else:
		continue_button.visible = false
		for choice_data in choices:
			var choice_button = choice_button_scene.instantiate()
			choice_button.set_text(choice_data.text)
			choice_button.choice_id = choice_data.next
			choice_button.owner_player_id = player_id
			choice_button.connect("chosen", Callable(self, "_on_choice_selected"))
			var connected = choice_button.is_connected("chosen", Callable(self, "_on_choice_selected"))
			print("🔌 Connected to ChoiceButton?", connected)
			choice_container.add_child(choice_button)
			
			print("👀 Spawned choice:", choice_data.text)

func clear_buttons() -> void:
	for child in choice_container.get_children():
		child.queue_free()
	continue_button.visible = false

func _on_continue_pressed() -> void:
	emit_signal("continue_requested")

func _on_choice_selected(choice_id: String, selected_player_id: int) -> void:
	
	# Confirm the right player made the choice
	if selected_player_id != player_id:
		print(selected_player_id, " is not equal to ", player_id )
		return
	print("📤 Emitting choice to DialogueSystem:", choice_id)
	emit_signal("choice_selected", choice_id, player_id)

func set_waiting_for_sync(waiting: bool) -> void:
	waiting_label.visible = waiting
