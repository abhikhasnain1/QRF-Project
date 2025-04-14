# Cursor2D.gd
extends Sprite2D

@export var player_id: int = 0
@export var move_speed: float = 300.0
@export var region_node_path: NodePath = ".." # Link to the Panel/region this cursor is limited to
@export var interact_action: String = "interact_p1"
@export var scroll_axis: int = JOY_AXIS_RIGHT_Y

func _ready():
	var region_node = get_node(region_node_path) as Control
	region_rect = region_node.get_global_rect()
	# Snap cursor to center of region at start
	global_position = region_rect.position + region_rect.size * 0.5

func _process(delta):
	var group_members = get_tree().get_nodes_in_group("ui_interactable")
	#print("Found interactables:", group_members.size())
	_move_cursor(delta)
	_handle_scroll()
	_handle_hover()
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

func _handle_hover():
	var under = get_control_under_cursor()
	if under and under.has_method("on_cursor_hover"):
		under.on_cursor_hover(self)
		
func get_control_under_cursor() -> Control:
	#var ui_pos = get_viewport().get_mouse_position()  # use screen-space position
	#var found = null
	#for node in get_tree().get_nodes_in_group("ui_interactable"):
		#if node is Control:
			#var rect = node.get_global_rect()
			#if rect.has_point(ui_pos):
				#print("✅ HIT:", node.name)
				#found = node
	#return found

	#print("💡 Checking for interactables...")
	for node in get_tree().get_nodes_in_group("ui_interactable"):
		if node is Control and node.get_global_rect().has_point(global_position):
			#print("Checking:", node.name, node.get_global_rect(), "vs cursor:", global_position)
			return node
			print(node)
	return null
	
	
	

func _handle_interaction():
	if Input.is_action_just_pressed(interact_action):
		print(player_id, interact_action)
		var under = get_control_under_cursor()
		if under and under.has_method("on_cursor_interact"):
			print(under)
			var owner_id := -1
			if "owner_player_id" in under:
				owner_id = under.get("owner_player_id")
			#var owner_id = under.get("owner_player_id") if under.has_method("get") and under.has_method("owner_player_id") else -1
			if owner_id == -1 or owner_id == player_id:
				under.on_cursor_interact(self)
				print(under)
			else:
				if under.has_method("on_cursor_hover"):
					print(under)
					under.on_cursor_hover(self)  # optional: show denied feedback

# Refactored _handle_interaction() to be used later:

#func _handle_interaction():
	#if Input.is_action_just_pressed(interact_action):
		#var under = get_control_under_cursor()
		#if under and under.has_method("on_cursor_interact"):
			#under.on_cursor_interact(self)
