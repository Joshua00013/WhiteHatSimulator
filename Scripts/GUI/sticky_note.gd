extends Node3D

var active

@export var password_text: String
@export var heading_text : String
@export var computer : Node3D

@export var paper_ui : PanelContainer
@export var password_label : Label
@export var heading : Label

@onready var return_button = $ReturnButton

func _ready() -> void:
	if password_text != null:
		password_label.text = password_text
	if heading_text != null:
		heading.text = heading_text
	
	if CyberattackAdaptationManager.noting_passwords == false:
		queue_free()
	
	# I want the sticky notes to appear then the users start to use strong passwords. Free it when weak passwords are used
	if CyberattackAdaptationManager.weak_passwords == true || CyberattackAdaptationManager.no_password_used == true:
		if CyberattackAdaptationManager.noting_passwords == true:
			queue_free()
			
	paper_ui.hide()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("exit_ui") && active == true:
		exit_ui()

func _on_interactable_interact_triggered() -> void:
	return_button.show()
	CyberattackAdaptationManager.noting_passwords = false
	
	if computer != null:
		password_label.text = "Pass: " + computer.login_screen.password
		heading.text = "Username: " + str(computer.login_screen.username)
	
	match OS.get_name():
		"Android":
			GameManager.android_ui.visible = false #Change Android UI visibility to hidden
			
	GameManager.player.exit_tool_tip.visible = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	GameManager.ui_active = true
	active = true
	paper_ui.show()
	
func exit_ui():
	return_button.hide()
	match OS.get_name():
		"Android":
			GameManager.android_ui.visible = true #Change Android UI visibility to shown
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	GameManager.player.exit_tool_tip.visible = false
	active = false
	GameManager.player_camera.current = true
	GameManager.ui_active = false
	paper_ui.hide()
