# ChoiceButton.gd
extends Control
@export var choice_id: String = ""
@export var owner_player_id: int = 0

@onready var animation_player = $AnimationPlayer

func on_cursor_hover(cursor):
	animation_player.play("hover")

func on_cursor_interact(cursor):
	if cursor.player_id == owner_player_id or owner_player_id == -1:
		animation_player.play("chosen")
		emit_signal("chosen", choice_id, cursor.player_id)
	else:
		animation_player.play("denied")  # Optional feedback
