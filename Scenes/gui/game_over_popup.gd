extends Control

@export var heading : Label
@export var body : Label

var reset_mouse := true

func _ready():
	UiManager.game_over_ui = self
	hide()

func display_popup(new_heading : String = "Game Over", new_body : String = "You have been caught", reset_mouse_check : bool = true):
	reset_mouse = reset_mouse_check
	heading.text = new_heading
	body.text = new_body
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	GameManager.ui_active = true
	show()

func _on_button_pressed():
	if reset_mouse:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		GameManager.ui_active = false
	hide()
