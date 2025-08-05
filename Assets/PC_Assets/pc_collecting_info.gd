extends Node3D

@onready var flashdrive: MeshInstance3D = $Flashdrive_red
@onready var usb_camera: Camera3D = $FlashDriveCamera

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
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("exit_ui") && active == true:
		exit_ui()
		
	if Input.is_action_pressed("hold") && active:
		var current_mouse_pos = get_viewport().get_mouse_position()
		var vertical_movement = current_mouse_pos.y - initial_cursor_y
		flashdrive.position.x = initial_flashdrive_x + vertical_movement * sensitivity

func _input(event):
	if event.is_action_pressed("hold") && active:
		#Set the initial position data for the cursor to be manipulated and tied to the flashdrive movement in physics process
		initial_cursor_y = get_viewport().get_mouse_position().y
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
	print("nigga")
	
func _on_area_3d_body_entered(body: Node3D) -> void:
	print("nigga")
				
func _on_interactable_interact_triggered() -> void:
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
