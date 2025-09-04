extends VBoxContainer

@export var window : Control

@onready var Icon: PackedScene = preload("res://Scenes/gui/CleanUI/icon.tscn")

#var newIcon = Icon.instantiate()
#add_child(newIcon)
	#
	#if newIcon != null:
		#print("May laman")


func _on_button_button_down() -> void:
	if window != null:
		window.visible = true
