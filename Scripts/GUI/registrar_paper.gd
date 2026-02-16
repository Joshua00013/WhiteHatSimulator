extends Node3D

var active

@export_enum(
	"al@company.com", 
	"brian@company.com", 
	"gigi@company.com",
	"joe@company.com", 
	"john@company.com", 
	"koro@company.com",
	"liz@company.com", 
	"mike@company.com", 
	"mococo@company.com",
	"myrione@company.com", 
	"robert@company.com", 
	"sai@company.com",
	"shion@company.com", 
	"walter@company.com", 
	"wisadel@company.com"
) var email_address: String
@export var paper_ui : PanelContainer
@export var label : Label

@onready var return_button = $ReturnButton

func _ready() -> void:
	paper_ui.hide()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("exit_ui") && active == true:
		exit_ui()

func _on_interactable_interact_triggered() -> void:
	return_button.show()
	match OS.get_name():
		"Android":
			GameManager.android_ui.visible = false #Change Android UI visibility to hidden
			
	label.text = email_address
	CyberattackManager.reconnaissance_finished = true
	CyberattackManager.set_email_usable(email_address, true)
	UiManager.popup.display_popup("Good job!", "You have found an employee's email.", false)
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
