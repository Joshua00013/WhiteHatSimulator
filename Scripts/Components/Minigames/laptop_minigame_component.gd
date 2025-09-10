extends Node3D

@export var flashdrive : Node3D
@export var camera : Camera3D
@export var laptop_camera : Camera3D
@export var flash_drive_item : InvItem

var position_minimum_x = Vector3(-0.941, 0.021, -0.350)
var starting_position = Vector3(-0.941, 0.021, -0.317)
var x_snap_position = Vector3(-0.941, 0.021, 0.036)
var laptop_snap_position = Vector3(-0.709, 0.021, 0.036)

var active := false
var sensitivity = 0.01
var dragging := false 
var initial_cursor_x = 0.0
var initial_flashdrive_x
var initial_flashdrive_z
var move_along_x := false

signal minigame_finished

func _process(_delta):
	if Input.is_action_just_pressed("exit_ui") && active == true:
		GameManager.add_item(flash_drive_item)
		exit_ui()
	if Input.is_action_pressed("hold") and active and dragging:
		var current_mouse_pos = get_viewport().get_mouse_position()
		var horizontal_movement = current_mouse_pos.x - initial_cursor_x
		
		if move_along_x:
			var new_x = initial_flashdrive_z - horizontal_movement * sensitivity * 0.1
			flashdrive.position.x = clamp(new_x, x_snap_position.x, laptop_snap_position.x)
		else:
			var new_z = initial_flashdrive_x + horizontal_movement * sensitivity * 0.08
			flashdrive.position.z = clamp(new_z, position_minimum_x.z, x_snap_position.z)
			if new_z >= x_snap_position.z:
				move_along_x = true
				initial_cursor_x = current_mouse_pos.x
				initial_flashdrive_z = flashdrive.position.x
		
func _input(event):
	if event.is_action_pressed("hold") and active:
		initial_cursor_x = get_viewport().get_mouse_position().x
		initial_flashdrive_x = flashdrive.position.z   # starting Z
		initial_flashdrive_z = flashdrive.position.x   # starting X
		dragging = true
	elif event.is_action_released("hold"):
		dragging = false

func initialize_minigame():
	flashdrive.position = starting_position
	camera.current = true

func minigame_start() -> void:
	
	match OS.get_name():
		"Android":
			GameManager.android_ui.visible = false #Change Android UI visibility to hidden
			
	if camera.is_current() == false:
		initialize_minigame()
		GameManager.player.exit_tool_tip.visible = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		GameManager.ui_active = true
		active = true

func exit_ui():
	match OS.get_name():
		"Android":
			GameManager.android_ui.visible = true #Change Android UI visibility to shown
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	GameManager.player.exit_tool_tip.visible = false
	active = false
	GameManager.player_camera.current = true
	GameManager.ui_active = false
