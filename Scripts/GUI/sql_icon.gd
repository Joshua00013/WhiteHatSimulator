extends VBoxContainer

@export var window : Control

@export var button : Button
@export var label : Label

@onready var color_rect: ColorRect = $Button/ColorRect

signal pressed

func _ready() -> void:
	if DayAndNightManager.initial_day == 5:
		color_rect.show()

func _on_button_button_down() -> void:
	if window != null:
		window.visible = true
	pressed.emit()
