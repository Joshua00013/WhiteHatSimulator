extends Control
@onready var radial_menu: Control = $ColorRect/RadialMenu


func _on_button_4_button_down() -> void:
	radial_menu.visible = true
