extends Button

func _on_pressed():
	if UiManager.nav_buttons_active == true:
		Input.action_press("next_pressed")
		Input.action_release("next_pressed")
