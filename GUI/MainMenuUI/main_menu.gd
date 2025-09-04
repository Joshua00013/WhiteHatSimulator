extends Control

@onready var settings = $Settings

func _on_start_pressed():
	get_tree().change_scene_to_file("res://Scenes/main.tscn")

func _on_settings_pressed():
	settings.visible = true

func _on_exit_pressed():
	get_tree().quit()


func _on_button_4_button_down():
	get_tree().change_scene_to_file("res://Scenes/gui/load_menu.tscn")
