extends Control

signal window_exited

func _on_exit_button_pressed() -> void:
	visible = false
	window_exited.emit()
	
