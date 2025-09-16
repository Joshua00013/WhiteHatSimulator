extends MarginContainer

signal post_ransomware_encrypt_exited

func _process(_delta: float) -> void:
	UiManager.nav_buttons_active = true
	if Input.is_action_just_pressed("next_pressed") && visible:
		post_ransomware_encrypt_exited.emit()

func _on_button_pressed() -> void:
	post_ransomware_encrypt_exited.emit()
