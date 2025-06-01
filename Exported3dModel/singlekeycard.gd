extends Node3D

var sensitivity = 0.01
var dragging = false
var camera : Camera3D
var screen_limit_ratio = 1  # 90% of the screen width

func _ready():
	camera = get_viewport().get_camera_3d()

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			dragging = event.pressed
	
	elif event is InputEventMouseMotion and dragging:
		var screen_pos = camera.unproject_position(global_transform.origin)
		var screen_width = get_viewport().get_visible_rect().size.y
		var screen_limit = screen_width * screen_limit_ratio

		if screen_pos.y < screen_limit:
			var delta_y = event.relative.y
			position.y -= delta_y * sensitivity *0.2
