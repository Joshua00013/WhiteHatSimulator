extends Node3D

var active := false
var message_active := false

@export var ui : CanvasLayer
@export var password_label: Label
@export var password : String = ""
@export var door : Node3D
@export var interactable : Area3D

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("exit_ui") && active == true:
		exit_ui()

func _on_interactable_interact_triggered() -> void:
	match OS.get_name():
		"Android":
			GameManager.android_ui.visible = false #Change Android UI visibility to hidden
			
	GameManager.player.exit_tool_tip.visible = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	GameManager.ui_active = true
	active = true
	ui.show()
	
func exit_ui():
	match OS.get_name():
		"Android":
			GameManager.android_ui.visible = true #Change Android UI visibility to shown
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	GameManager.player.exit_tool_tip.visible = false
	active = false
	GameManager.player_camera.current = true
	GameManager.ui_active = false
	ui.hide()

func _on_texture_button_button_down() -> void:
	key_press("1")

func _on_texture_button_2_button_down() -> void:
	key_press("2")

func _on_texture_button_3_button_down() -> void:
	key_press("3")

func _on_texture_button_4_button_down() -> void:
	key_press("4")

func _on_texture_button_5_button_down() -> void:
	key_press("5")

func _on_texture_button_6_button_down() -> void:
	key_press("6")

func _on_texture_button_7_button_down() -> void:
	key_press("7")

func _on_texture_button_8_button_down() -> void:
	key_press("8")

func _on_texture_button_9_button_down() -> void:
	key_press("9")

func _on_texture_button_12_pressed():
	key_press("10")

func key_press(digit):
	if len(password_label.text) == 4:
		return
	if message_active == true:
		password_label.text = ""
		message_active = false
	password_label.text += digit

func check_pass():
	if password_label.text != password:
		password_label.text = "ERROR!"
		message_active = true
	else:
		minigame_success()
		
func minigame_success():
	if door.locked == true:
		door.unlock()
		door.interactable.trigger()
		interactable.set_collision_layer_value(2, false)
		exit_ui()
