extends Control

signal decryptor_window_finished

func _on_exit_button_pressed() -> void:
	visible = false
	decryptor_window_finished.emit()
