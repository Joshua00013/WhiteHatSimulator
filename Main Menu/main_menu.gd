extends Control

func _ready():
	pass

func _process(delta):
	pass
	
func _on_start_pressed():
	get_tree().change_scene_to_file("res://Scenes/main.tscn")

func _on_settings_pressed():
	pass # Replace with function body.

func _on_exit_pressed():
	get_tree().quit()
