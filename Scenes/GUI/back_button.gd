extends Button

func _ready():
	UiManager.back_button = self

func _on_pressed():
	Input.action_press("back_pressed")
	Input.action_release("back_pressed")
