extends Node3D

@onready var card_camera: Camera3D = $Camera3D
@onready var keycard: Node3D = $keycard

var sensitivity = 0.01
var dragging = false
var screen_limit_ratio = 1  # 90% of the screen width
var active := false
var last_mouse_y := 192.0 # Initial value of the object position relative to the mouse

func _ready():
	keycard.visible = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("exit_ui") && active == true:
		exit_ui()

func _input(event):
	if active == true:
		keycard.visible = true
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT:
				dragging = event.pressed
				last_mouse_y = event.position.y
		elif event is InputEventMouseMotion and dragging:
			var screen_pos = card_camera.unproject_position(global_transform.origin)
			var screen_width = get_viewport().get_visible_rect().size.y
			var screen_limit = screen_width * screen_limit_ratio

			if screen_pos.y < screen_limit:
				var delta_y = event.relative.y # Production comment: Replace event with the actual position of the mouse.
				keycard.position.y -= delta_y * sensitivity *0.2
				
	if Input.is_action_pressed("hold"):
			var mouse_pos = get_viewport().get_mouse_position()
			var screen_pos = card_camera.unproject_position(global_transform.origin)
			var screen_height = get_viewport().get_visible_rect().size.y
			var screen_limit = screen_height * screen_limit_ratio

			if screen_pos.y < screen_limit:
				var delta_y = mouse_pos.y - last_mouse_y #last_mouse is the starting position of the mouse according to the object
				keycard.position.y -= delta_y * sensitivity * 0.2
				last_mouse_y = mouse_pos.y
				
func _on_interactable_interact_triggered() -> void:
	match OS.get_name():
		"Android":
			GameManager.android_ui.visible = false #Change Android UI visibility to hidden
			
	if card_camera.is_current() == false:
		GameManager.player.exit_tool_tip.visible = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		card_camera.current = true
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
