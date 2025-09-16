extends Control

func _ready():
	UiManager.game_over_ui = self
	visible = false

func play():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().paused = true
	visible = true

func _on_button_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()
