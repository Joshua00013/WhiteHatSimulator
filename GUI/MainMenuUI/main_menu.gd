extends Control

@export var settings : Control

func _ready():
	DayAndNightManager.active = false

func _on_start_pressed():
	get_tree().change_scene_to_file("res://Scenes/GUI/loading.tscn")

func _on_load_pressed():
	get_tree().change_scene_to_file("res://Scenes/gui/load_menu.tscn")

func _on_settings_pressed():
	settings.show()

func _on_quit_pressed():
	get_tree().quit()
