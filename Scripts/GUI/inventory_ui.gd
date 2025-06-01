extends Control

func _ready() -> void:
	GameManager.ui_active = false
	close()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("inventory"):
		if GameManager.ui_active == true:
			close()
		else:
			open()

func open():
	visible = true
	GameManager.ui_active = true

func close():
	visible = false
	GameManager.ui_active = false
