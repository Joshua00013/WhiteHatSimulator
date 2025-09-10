extends Node3D

@export var flashdrive: CharacterBody3D

var sensitivity = 0.01
var active := false
var dragging := false
var initial_cursor_x = 0.0
var initial_flashdrive_x
var initial_flashdrive_z
var move_along_x := false

var position_minimum_x = Vector3(-0.941, 0.021, -0.350)
var starting_position = Vector3(-0.941, 0.021, -0.317)
var y_snap_position = Vector3(-0.941, 0.021, 0.036)
var laptop_snap_position = Vector3(-0.709, 0.021, 0.036)

func _process(delta):
	if Input.is_action_pressed("hold") and active and dragging:
		var current_mouse_pos = get_viewport().get_mouse_position()
		var horizontal_movement = current_mouse_pos.x - initial_cursor_x
		
		# Calculate new Z position based on mouse movement
		var new_z = initial_flashdrive_z + horizontal_movement * sensitivity * 0.05
		
		# Clamp Z between position_minimum_x.z and y_snap_position.z
		flashdrive.position.z = clamp(new_z, position_minimum_x.z, y_snap_position.z)

func _input(event): 
	if event.is_action_pressed("hold") and active:
		initial_cursor_x = get_viewport().get_mouse_position().x
		initial_flashdrive_z = flashdrive.position.z  # store Z position
		initial_flashdrive_x = flashdrive.position.x  # store X position (for future use)
		dragging = true
	elif event.is_action_released("hold"):
		dragging = false
