extends Node3D

# Used for checking if the mouse is inside the Area3D.
var is_mouse_inside = false
# The last processed input touch/mouse event. To calculate relative movement.
var last_event_pos2D = null
# The time of the last event in seconds since engine start.
var last_event_time: float = -1.0

var active := false

@export var username: String
@export var password : String
@export var tab : TabContainer
@export var login_screen : Control
@export var laptop_inv_item : InvItem
@export var flashdrive_min_z: float = -0.35
@export var flashdrive_max_z: float = 0.035
@export var flashdrive_min_x: float = -0.94
@export var flashdrive_max_x: float = -0.72

@onready var usb_camera: Camera3D = $Flashdrive_camera
@onready var flashdrive: CharacterBody3D = $FlashDriveCollectible
@onready var node_viewport = $SubViewport
@onready var node_quad = $laptop_base/laptop_screen/Screen
@onready var camera = $Camera3D
@onready var node_area = $laptop_base/laptop_screen/Screen/Area3D
@onready var animation_player = $AnimationPlayer

var sensitivity = 0.01
var dragging := false
var blocked := false 
var initial_cursor_x = 0.0
var initial_flashdrive_x
var initial_flashdrive_z
var move_along_x := false

signal closed

func _ready():
	animation_player.play("open_laptop")
	
	flashdrive.visible = false
	login_screen.password = password
	login_screen.username = username
	
	node_area.mouse_entered.connect(_mouse_entered_area)
	node_area.mouse_exited.connect(_mouse_exited_area)
	node_area.input_event.connect(_mouse_input_event)

func _mouse_entered_area():
	is_mouse_inside = true

func _mouse_exited_area():
	is_mouse_inside = false

func _process(delta):
	if Input.is_action_just_pressed("exit_ui") and active:
		exit_ui()

	if Input.is_action_pressed("hold") and active and dragging:
		var current_mouse_pos = get_viewport().get_mouse_position()
		var horizontal_movement = current_mouse_pos.x - initial_cursor_x
		
		if move_along_x:
			var new_x = initial_flashdrive_z - horizontal_movement * sensitivity * 0.05
			flashdrive.position.x = clamp(new_x, flashdrive_min_x, flashdrive_max_x)
			if new_x >= flashdrive_max_x:
				exit_ui()
		else:
			var new_z = initial_flashdrive_x + horizontal_movement * sensitivity * 0.05
			flashdrive.position.z = clamp(new_z, flashdrive_min_z, flashdrive_max_z)
			
			if new_z >= flashdrive_max_z:
				move_along_x = true
				
				initial_cursor_x = current_mouse_pos.x
				initial_flashdrive_z = flashdrive.position.x

func _input(event): 
	if event.is_action_pressed("hold") and active and not blocked:
		initial_cursor_x = get_viewport().get_mouse_position().x
		initial_flashdrive_x = flashdrive.position.z   # starting Z
		initial_flashdrive_z = flashdrive.position.x   # starting X
		dragging = true
	elif event.is_action_released("hold"):
		dragging = false
		
func _unhandled_input(event):
	if event is InputEventKey && event.keycode == KEY_ESCAPE:
		return
	# Check if the event is a non-mouse/non-touch event
	for mouse_event in [InputEventMouseButton, InputEventMouseMotion, InputEventScreenDrag, InputEventScreenTouch]:
		if is_instance_of(event, mouse_event):
			# If the event is a mouse/touch event, then we can ignore it here, because it will be
			# handled via Physics Picking.
			return
	node_viewport.push_input(event)

func _mouse_input_event(_camera: Camera3D, event: InputEvent, event_position: Vector3, _normal: Vector3, _shape_idx: int):
	# Get mesh size to detect edges and make conversions. This code only support PlaneMesh and QuadMesh.
	var quad_mesh_size = node_quad.mesh.size

	# Event position in Area3D in world coordinate space.
	var event_pos3D = event_position

	# Current time in seconds since engine start.
	var now: float = Time.get_ticks_msec() / 1000.0

	# Convert position to a coordinate space relative to the Area3D node.
	# NOTE: affine_inverse accounts for the Area3D node's scale, rotation, and position in the scene!
	event_pos3D = node_quad.global_transform.affine_inverse() * event_pos3D

	var event_pos2D: Vector2 = Vector2()

	if is_mouse_inside:
		# Convert the relative event position from 3D to 2D.
		event_pos2D = Vector2(event_pos3D.x, -event_pos3D.y)

		# Right now the event position's range is the following: (-quad_size/2) -> (quad_size/2)
		# We need to convert it into the following range: -0.5 -> 0.5
		event_pos2D.x = event_pos2D.x / quad_mesh_size.x
		event_pos2D.y = event_pos2D.y / quad_mesh_size.y
		# Then we need to convert it into the following range: 0 -> 1
		event_pos2D.x += 0.5
		event_pos2D.y += 0.5

		# Finally, we convert the position to the following range: 0 -> viewport.size
		event_pos2D.x *= node_viewport.size.x
		event_pos2D.y *= node_viewport.size.y
		# We need to do these conversions so the event's position is in the viewport's coordinate system.

	elif last_event_pos2D != null:
		# Fall back to the last known event position.
		event_pos2D = last_event_pos2D

	# Set the event's position and global position.
	event.position = event_pos2D
	if event is InputEventMouse:
		event.global_position = event_pos2D

	# Calculate the relative event distance.
	if event is InputEventMouseMotion or event is InputEventScreenDrag:
		# If there is not a stored previous position, then we'll assume there is no relative motion.
		if last_event_pos2D == null:
			event.relative = Vector2(0, 0)
		# If there is a stored previous position, then we'll calculate the relative position by subtracting
		# the previous position from the new position. This will give us the distance the event traveled from prev_pos.
		else:
			event.relative = event_pos2D - last_event_pos2D
			event.velocity = event.relative / (now - last_event_time)

	# Update last_event_pos2D with the position we just calculated.
	last_event_pos2D = event_pos2D

	# Update last_event_time to current time.
	last_event_time = now
	
	# Finally, send the processed input event to the viewport.
	node_viewport.push_input(event)

func _on_interactable_interact_triggered():
	if not has_flashdrive():
		print("Flashdrive not in inventory.")
		return
		
	if usb_camera.is_current() == false:
		GameManager.player.exit_tool_tip.visible = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		usb_camera.current = true
		GameManager.ui_active = true
		active = true
		flashdrive.visible = true

func exit_ui():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	GameManager.player.exit_tool_tip.visible = false
	active = false
	GameManager.player_camera.current = true
	GameManager.ui_active = false
	
	
	animation_player.play("close_laptop")
	GameManager.add_item(laptop_inv_item)
	#TODO: Create a signal to let the parent know that the laptop is gone. Add a laptop to the player inventory
	
func _on_login_login_successful():
	tab.current_tab = 1
	
func free_laptop():
	closed.emit()
	call_deferred("queue_free")
	
func has_flashdrive() -> bool:
	for item in GameManager.inv.inv.items:
		if item != null:
			if item.name == "Flash Drive":
				return true
	return false
