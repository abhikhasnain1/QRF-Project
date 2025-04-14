extends Control

func set_current_text(text: String) -> void:
	pass
	# sets the active RichTextLabel line

func show_choices(choices: Array) -> void:
	pass
	# clears previous buttons
	# instances ChoiceButtons
	# connects 'chosen' to DialogueSystem.load_node(next_id)
