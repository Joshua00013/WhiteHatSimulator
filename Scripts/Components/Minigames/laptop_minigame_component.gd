extends Node3D

@export var flash_drive : Node3D
@export var camera : Camera3D
@export var laptop_camera : Camera3D
@export var flash_drive_item : InvItem
var target_position : Vector3 = Vector3(-0.862, 0.019, 0.039)
var h_snap_position : Vector3 = Vector3(-0.862, 0.019, 0.039)
var starting_position : Vector3 = Vector3(-0.862, 0.019, 0.273)

var active := false
var sensitivity = 0.01
var dragging = false
var screen_limit_ratio = 1  # 90% of the screen width
var last_mouse_y := 192.0 # Initial value of the object position relative to the mouse

signal minigame_finished

func _process(_delta):
	if Input.is_action_just_pressed("exit_ui") && active == true:
		GameManager.add_item(flash_drive_item)
		exit_ui()
		
func _input(event):
	if active == true:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT:
				dragging = event.pressed
				last_mouse_y = event.position.y
		elif event is InputEventMouseMotion and dragging:
			var screen_pos = camera.unproject_position(global_transform.origin)
			var screen_width = get_viewport().get_visible_rect().size.y
			var screen_limit = screen_width * screen_limit_ratio

			if screen_pos.y < screen_limit:
				var delta_y = event.relative.y # Production comment: Replace event with the actual position of the mouse.
				flash_drive.position.y -= delta_y * sensitivity *0.2
				if flash_drive.position.y < -0.4:
					minigame_finished.emit()
				
		if Input.is_action_pressed("hold"):
				var mouse_pos = get_viewport().get_mouse_position()
				var screen_pos = camera.unproject_position(global_transform.origin)
				var screen_height = get_viewport().get_visible_rect().size.y
				var screen_limit = screen_height * screen_limit_ratio

				if screen_pos.y < screen_limit:
					var delta_y = mouse_pos.y - last_mouse_y #last_mouse is the starting position of the mouse according to the object
					flash_drive.position.y -= delta_y * sensitivity * 0.2
					last_mouse_y = mouse_pos.y

func initialize_minigame():
	flash_drive.position = starting_position
	camera.current = true

func minigame_start() -> void:
	initialize_minigame()
	match OS.get_name():
		"Android":
			GameManager.android_ui.visible = false #Change Android UI visibility to hidden
			
	if camera.is_current() == false:
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
