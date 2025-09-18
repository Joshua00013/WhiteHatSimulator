@tool
extends VBoxContainer

@export var window : Control
@export var icon: Texture2D:
	set(value):
		if button != null:
			icon = value
			button.icon = icon
@export var icon_name : String:
	set(value):
		if label != null:
			icon_name = value
			label.text = icon_name

@export var button : Button
@export var label : Label


func _on_button_button_down() -> void:
	if window != null:
		window.visible = true
