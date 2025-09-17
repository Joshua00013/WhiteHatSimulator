extends Button

func _on_pressed():
		Input.action_press("next_pressed")
		Input.action_release("next_pressed")
