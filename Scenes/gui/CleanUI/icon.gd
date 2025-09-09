extends VBoxContainer

@export var window : Control

func _on_button_button_down() -> void:
	if window != null:
		window.visible = true
