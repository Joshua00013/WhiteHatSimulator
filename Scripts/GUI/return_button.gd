extends Button

func _on_pressed():
	GameManager.ui_active = false
	Input.action_press("exit_ui")
	Input.action_release("exit_ui")
