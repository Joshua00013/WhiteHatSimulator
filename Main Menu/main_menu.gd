extends Control

func _ready():
	pass

func _process(delta):
	pass
	
func _on_start_pressed():
	get_tree().change_scene_to_file("res://Scenes/main.tscn")

func _on_settings_pressed():
	get_tree().change_scene_to_file("res://Main Menu/mainMenu#2/Main_menu/settings.tscn")

func _on_exit_pressed():
	get_tree().quit()
