# ChoiceButton.gd
@tool

extends Control
class_name ChoiceButton


# Inherits Interactable behavior
@export var choice_id: String = ""
@export var owner_player_id: int = 0  # 0 = player 1, 1 = player 2, -1 = shared

signal chosen(choice_id: String, player_id: int)

@onready var label: Label = $Label
@onready var anim: AnimationPlayer = $AnimationPlayer

func set_text(text: String) -> void:
	label.text = text

func on_cursor_hover(cursor):
	if _is_owned_by(cursor.player_id):
		anim.play("hover")
	else:
		anim.play("denied")

func on_cursor_interact(cursor):
	if _is_owned_by(cursor.player_id):
		anim.play("chosen")
		emit_signal("chosen", choice_id, cursor.player_id)
	else:
		anim.play("denied")
