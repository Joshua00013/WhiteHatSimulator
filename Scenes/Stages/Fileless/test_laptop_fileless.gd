extends Node3D

# Used for checking if the mouse is inside the Area3D.
var is_mouse_inside = false
# The last processed input touch/mouse event. To calculate relative movement.
var last_event_pos2D = null
# The time of the last event in seconds since engine start.
var last_event_time: float = -1.0

var active := false

@export var animation: AnimationPlayer
@export var tab: TabContainer
@export var laptop_inv_item: InvItem
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
			if new_x >= flashdrive_max_x && camera.is_current() == false:
				GameManager.player.exit_tool_tip.visible = true
				Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
				camera.current = true
				GameManager.ui_active = true
				active = true
				animation.play("yes_flashdrive")
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
	var quad_mesh_size = node_quad.mesh.size
	var event_pos3D = event_position
	var now: float = Time.get_ticks_msec() / 1000.0
	event_pos3D = node_quad.global_transform.affine_inverse() * event_pos3D

	var event_pos2D: Vector2 = Vector2()

	if is_mouse_inside:
		event_pos2D = Vector2(event_pos3D.x, -event_pos3D.y)
		event_pos2D.x = event_pos2D.x / quad_mesh_size.x
		event_pos2D.y = event_pos2D.y / quad_mesh_size.y
		event_pos2D.x += 0.5
		event_pos2D.y += 0.5
		event_pos2D.x *= node_viewport.size.x
		event_pos2D.y *= node_viewport.size.y
	elif last_event_pos2D != null:
		event_pos2D = last_event_pos2D

	event.position = event_pos2D
	if event is InputEventMouse:
		event.global_position = event_pos2D

	if event is InputEventMouseMotion or event is InputEventScreenDrag:
		if last_event_pos2D == null:
			event.relative = Vector2(0, 0)
		else:
			event.relative = event_pos2D - last_event_pos2D
			event.velocity = event.relative / (now - last_event_time)

	last_event_pos2D = event_pos2D
	last_event_time = now
	node_viewport.push_input(event)

func _on_interactable_interact_triggered():
	if not has_flashdrive():
		if camera.is_current() == false:
			GameManager.player.exit_tool_tip.visible = true
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			camera.current = true
			GameManager.ui_active = true
			active = true
			animation.play("no_flashdrive")
	
	if has_flashdrive():
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
