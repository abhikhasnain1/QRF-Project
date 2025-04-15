# Interactable.gd
class_name Interactable
extends Control


@export var owner_player_id: int = -1  # -1 = shared
@export var triggers: Array = []

signal hovered(cursor)
signal interacted(cursor)
signal denied(cursor)

func on_cursor_hover(cursor):
	if _is_owned_by(cursor.player_id):
		emit_signal("hovered", cursor)
	else:
		emit_signal("denied", cursor)

func on_cursor_interact(cursor):
	if _is_owned_by(cursor.player_id):
		emit_signal("interacted", cursor)
		
	else:
		emit_signal("denied", cursor)

func _is_owned_by(player_id: int) -> bool:
	return owner_player_id == -1 or owner_player_id == player_id
