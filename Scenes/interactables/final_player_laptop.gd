extends Node3D

@onready var flashdrive: MeshInstance3D = $Flashdrive_red
@onready var usb_camera: Camera3D = $"Camera3D-Flashdrive"
@onready var inv : Inv = preload("res://Items/player_inventory.tres")

var sensitivity = 0.01
var active := false
var dragging := false
var blocked := false 
var initial_cursor_x = 0.0
var initial_flashdrive_x
var initial_flashdrive_z
var move_along_z := false

func _ready():
	flashdrive.visible = false
	initial_flashdrive_x = flashdrive.position.x
	initial_flashdrive_z = flashdrive.position.z

func _process(delta):
	if Input.is_action_pressed("hold") and active and dragging:
		var current_mouse_pos = get_viewport().get_mouse_position()
		var horizontal_movement = current_mouse_pos.x - initial_cursor_x
		if move_along_z:
			flashdrive.position.z = initial_flashdrive_z - horizontal_movement * sensitivity * 0.1
		else:
			flashdrive.position.x = initial_flashdrive_x - horizontal_movement * sensitivity * 0.05

func _input(event): 
	if event.is_action_pressed("hold") and active and not blocked:
		initial_cursor_x = get_viewport().get_mouse_position().x
		initial_flashdrive_x = flashdrive.position.x
		initial_flashdrive_z = flashdrive.position.z
		dragging = true
	elif event.is_action_released("hold"):
		dragging = false
		blocked = false # allow dragging again after release

func has_flashdrive() -> bool:
	for item in GameManager.inv.inv.items:
		if item != null:
			if item.name == "Flash Drive":
				return true
	return false
	
func exit_ui():
	match OS.get_name():
		"Android":
			GameManager.android_ui.visible = true #Change Android UI visibility to shown
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	GameManager.player.exit_tool_tip.visible = false
	active = false
	GameManager.player_camera.current = true
	GameManager.ui_active = false


func _on_area_3_dright_area_entered(area: Area3D) -> void:
	move_along_z = true
	
	if dragging:
		initial_cursor_x = get_viewport().get_mouse_position().x
		initial_flashdrive_z = flashdrive.position.z

func _on_area_3_dleft_area_entered(area: Area3D) -> void:
	dragging = false
	blocked = true  # prevents immediate dragging again

func _on_area_3_dflashdrivechecker_area_entered(area: Area3D) -> void:
	exit_ui()

func _on_interactable_interact_triggered() -> void:
	if not has_flashdrive():
		print("Flashdrive not in inventory.")
		return
		
	match OS.get_name():
		"Android":
			GameManager.android_ui.visible = false #Change Android UI visibility to hidden
				
	if usb_camera.is_current() == false:
		GameManager.player.exit_tool_tip.visible = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		usb_camera.current = true
		GameManager.ui_active = true
		active = true
		flashdrive.visible = true
