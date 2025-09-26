extends Control

signal window_exited

@export var password : Label

func _ready() -> void:
	if DayAndNightManager.initial_day == 5:
		password.text = CyberattackManager.server_room_password

func _on_exit_button_pressed() -> void:
	visible = false
	window_exited.emit()
