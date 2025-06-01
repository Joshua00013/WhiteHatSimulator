extends Node3D

var sensitivity = 0.01
var dragging = false
var camera : Camera3D
var moving_in_z = false
var screen_limit_ratio = 0.64

var active := false
func _on_interactable_interact_triggered():
	if camera.is_current() == false:
		GameManager.player.exit_tool_tip.visible = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		camera.current = true
		GameManager.ui_active = true
		active = true
		
func exit_ui():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	GameManager.player.exit_tool_tip.visible = false
	active = false
	GameManager.player_camera.current = true
	GameManager.ui_active = false

func _ready():
	camera = get_viewport().get_camera_3d()

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			dragging = event.pressed
			if not dragging:
				moving_in_z = false  # Reset when done dragging

	elif event is InputEventMouseMotion and dragging:
		var screen_pos = camera.unproject_position(global_transform.origin)
		var screen_width = get_viewport().get_visible_rect().size.x
		var screen_limit = screen_width * screen_limit_ratio

		if not moving_in_z:
			if screen_pos.x < screen_limit:
				position.x += event.relative.x * sensitivity
			else:
				moving_in_z = true
		else:
			position.z -= event.relative.y * sensitivity 
