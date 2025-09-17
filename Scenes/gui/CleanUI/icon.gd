@tool
extends VBoxContainer

@export var window : Control
@export var icon: Texture2D:
	set(value):
		icon = value
		button.icon = value
@export var icon_name : String:
	set(value):
		icon_name = value
		label.text = value

@onready var button = $Button
@onready var label = $Label


func _on_button_button_down() -> void:
	if window != null:
		window.visible = true
