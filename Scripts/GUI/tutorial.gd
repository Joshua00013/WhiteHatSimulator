extends Control

var change_mouse := false
func _ready() -> void:
	UiManager.tutorial_ui = self
	hide()

func display_tutorial(from_pause := false):
	change_mouse = from_pause
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	GameManager.ui_active = true
	show()

func quit():
	if change_mouse == false:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	GameManager.ui_active = false
	hide()

func _on_texture_button_pressed() -> void:
	quit()
