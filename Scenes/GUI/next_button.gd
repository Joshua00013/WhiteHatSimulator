extends Button

func _ready():
	UiManager.next_button = self

func _on_pressed():
		Input.action_press("next_pressed")
		Input.action_release("next_pressed")
