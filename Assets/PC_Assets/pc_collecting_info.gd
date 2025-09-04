extends Node3D

@onready var flashdrive: MeshInstance3D = $Flashdrive_red
@onready var usb_camera: Camera3D = $FlashDriveCamera
@onready var inv : Inv = preload("res://Items/player_inventory.tres")

var sensitivity = 0.01
var dragging = false
var screen_limit_ratio = 1  # 90% of the screen width
var active := false
var last_mouse_x := 192.0
var initial_cursor_y = 0.0
var initial_flashdrive_x

func _ready():
	flashdrive.visible = false
	initial_flashdrive_x = flashdrive.position.x #Store data for default flashdrive position for later use
	
func _process(delta):

	if Input.is_action_pressed("hold") and active and dragging:
		var current_mouse_pos = get_viewport().get_mouse_position()
		var vertical_movement = current_mouse_pos.y - initial_cursor_y
		flashdrive.position.x = initial_flashdrive_x + vertical_movement * sensitivity

func _input(event): 

	if event.is_action_pressed("hold") and active:
		initial_cursor_y = get_viewport().get_mouse_position().y
		initial_flashdrive_x = flashdrive.position.x
		dragging = true
	elif event.is_action_released("hold"):
		dragging = false
	
		
	#if active == true:
		#flashdrive.visible = true
		#if event is InputEventMouseButton:
			#if event.button_index == MOUSE_BUTTON_LEFT:
				#dragging = event.pressed
		#elif event is InputEventMouseMotion and dragging:
				#var delta_x = event.relative.x # Production comment: Replace event with the actual position of the mouse.
				#flashdrive.position.x -= delta_x * sensitivity *0.2
				
func _on_area_3d_area_entered(area: Area3D) -> void:
	dragging = false
	exit_ui()

func has_flashdrive() -> bool:
	for item in GameManager.inv.inv.items:
		if item != null:
			if item.name == "Flash Drive":
				return true
	return false
	
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
		

		

func exit_ui():
	match OS.get_name():
		"Android":
			GameManager.android_ui.visible = true #Change Android UI visibility to shown
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	GameManager.player.exit_tool_tip.visible = false
	active = false
	GameManager.player_camera.current = true
	GameManager.ui_active = false
