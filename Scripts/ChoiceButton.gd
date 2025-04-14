# ChoiceButton.gd
@tool

extends "res://Scripts/Interactable.gd"
class_name ChoiceButton


# Inherits Interactable behavior
@export var choice_id: String = ""
@export var triggers: Array[String] = []


signal chosen(choice_id: String, player_id: int)

@onready var label: Label = $Container/MarginContainer/Label
@onready var anim: AnimationPlayer = $AnimationPlayer

func set_text(text: String) -> void:
	$Container/MarginContainer/Label.text = text

func _ready():
	add_to_group("ui_interactable")
	print("✅ Added to group:", self.name)


func on_cursor_hover(cursor):
	if _is_owned_by(cursor.player_id):
		play_effect(ButtonEffect.HOVER)
		#anim.play("hover")
	else:
		play_effect(ButtonEffect.DENY)

		#anim.play("denied")

func on_cursor_interact(cursor):
	if _is_owned_by(cursor.player_id):
		play_effect(ButtonEffect.RESET)
		anim.play("chosen")
		emit_signal("chosen", choice_id, cursor.player_id, triggers)
	else:
		play_effect(ButtonEffect.DENY)
		anim.play("denied")

func play_hover_effect():
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1.05, 1.05), 0.1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

func play_reset_scale():
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2.ONE, 0.1)

func play_deny_shake():
	var tween = create_tween()
	tween.tween_property(self, "position:x", position.x - 10, 0.05)
	tween.tween_property(self, "position:x", position.x + 10, 0.05)
	tween.tween_property(self, "position:x", position.x, 0.05)
	
enum ButtonEffect { HOVER, RESET, DENY }

func play_effect(effect: ButtonEffect):
	match effect:
		ButtonEffect.HOVER: play_hover_effect()
		ButtonEffect.RESET: play_reset_scale()
		ButtonEffect.DENY: play_deny_shake()
