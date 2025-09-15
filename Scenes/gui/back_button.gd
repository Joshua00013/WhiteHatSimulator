extends Button

func _on_pressed():
	Input.action_press("back_pressed")
	Input.action_release("back_pressed")
