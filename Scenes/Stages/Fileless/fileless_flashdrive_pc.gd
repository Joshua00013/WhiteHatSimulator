extends Node3D

@export var flashdrive_item : InvItem
@export var flashdrive_min_z: float = 0.09
@export var flashdrive_max_z: float = 0.265
@export var flashdrive_min_x: float = -1.15
@export var flashdrive_max_x: float = -0.7
var sensitivity = 0.01
var dragging := false
var blocked := false 
var initial_cursor_x = 0.0
var initial_flashdrive_x
var initial_flashdrive_z
var move_along_x := false
var active := false

@onready var usb_camera: Camera3D = $Flashdrivecamera
@onready var flashdrive: CharacterBody3D = $FlashDriveCollectible

func _ready() -> void:
	flashdrive.visible = false
func _process(delta):
	if Input.is_action_just_pressed("exit_ui") and active:
		exit_ui()
	if Input.is_action_pressed("hold") and active and dragging:
		var current_mouse_pos = get_viewport().get_mouse_position()
		var horizontal_movement = current_mouse_pos.x - initial_cursor_x
		
		if move_along_x:
			var new_z = initial_flashdrive_z + horizontal_movement * sensitivity * 0.05
			flashdrive.position.x = clamp(new_z, flashdrive_min_z, flashdrive_max_z)
			if new_z >= flashdrive_min_z == false:
				CyberattackManager.fileless_delivery_finished = true
				exit_ui()
				GameManager.remove_item(flashdrive_item)
				
		else:
			var new_x = initial_flashdrive_x - horizontal_movement * sensitivity * 0.05
			flashdrive.position.z = clamp(new_x, flashdrive_min_x, flashdrive_max_x)
			
			if new_x <= flashdrive_min_x:
				move_along_x = true
				initial_cursor_x = current_mouse_pos.x
				initial_flashdrive_z = flashdrive.position.x
			
			
				
func _input(event): 
	if event.is_action_pressed("hold") and active and not blocked:
		initial_cursor_x = get_viewport().get_mouse_position().x
		initial_flashdrive_z = flashdrive.position.x   # starting Z
		initial_flashdrive_x = flashdrive.position.z   # starting X
		dragging = true
	elif event.is_action_released("hold"):
		dragging = false

func _on_interactable_interact_triggered():
	if not has_flashdrive():
			print("no flashdrive")
			
	if has_flashdrive() && CyberattackManager.fileless_weap_finished == true:
		if usb_camera.is_current() == false:
			GameManager.player.exit_tool_tip.visible = true
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			usb_camera.current = true
			GameManager.ui_active = true
			active = true
			flashdrive.visible = true
			
func has_flashdrive() -> bool:
	for item in GameManager.inv.inv.items:
		if item != null:
			if item.name == "Flash Drive":
				return true
	return false
	
func exit_ui():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	GameManager.player.exit_tool_tip.visible = false
	active = false
	GameManager.player_camera.current = true
	GameManager.ui_active = false
	flashdrive.visible = false
