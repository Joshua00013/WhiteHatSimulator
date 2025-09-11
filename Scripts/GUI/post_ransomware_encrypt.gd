extends MarginContainer

signal post_ransomware_encrypt_exited

func _on_button_pressed() -> void:
	post_ransomware_encrypt_exited.emit()
