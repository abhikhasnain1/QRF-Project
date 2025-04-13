# Cursor2D.gd
extends Sprite2D

@export var player_id: int = 0
@export var move_speed: float = 300.0
@export var region_node_path: NodePath = ".." # Link to the Panel/region this cursor is limited to
@export var interact_action: String = "interact_p1"
@export var scroll_axis: int = JOY_AXIS_RIGHT_Y

#var region_rect := Rect2()

func _ready():
	var region_node = get_node(region_node_path) as Control
	region_rect = region_node.get_global_rect()
	# Snap cursor to center of region at start
	global_position = region_rect.position + region_rect.size * 0.5

func _process(delta):
	_move_cursor(delta)
	_handle_scroll()
	_handle_interaction()

func _move_cursor(delta):
	var axis_x = Input.get_joy_axis(player_id, JOY_AXIS_LEFT_X)
	var axis_y = Input.get_joy_axis(player_id, JOY_AXIS_LEFT_Y)
	var input_vec = Vector2(axis_x, axis_y).limit_length(1.0)
	global_position += input_vec * move_speed * delta
	# Keep inside region
	global_position.x = clamp(global_position.x, region_rect.position.x, region_rect.position.x + region_rect.size.x)
	global_position.y = clamp(global_position.y, region_rect.position.y, region_rect.position.y + region_rect.size.y)

func _handle_scroll():
	var under = get_control_under_cursor()
	if under and under is ScrollContainer:
		var scroll_input = Input.get_joy_axis(player_id, scroll_axis)
		if abs(scroll_input) > 0.1:  # deadzone threshold
			under.scroll_vertical += scroll_input * 20.0

func get_control_under_cursor() -> Control:
	for node in get_tree().get_nodes_in_group("ui_interactable"):
		if node is Control and node.get_global_rect().has_point(global_position):
			return node
	return null

func _handle_interaction():
	if Input.is_action_just_pressed(interact_action):
		var under = get_control_under_cursor()
		if under:
			if under is BaseButton:
				under.emit_signal("pressed")
				print(player_id, " ", under)
			#elif under is ScrollContainer:
				#print(under)
				#var scroll = Input.get_joy_axis(player_id, scroll_axis)
				#if abs(scroll) > 0.1:
					#under.scroll_vertical += scroll * 20  # adjust scroll speed if needed
