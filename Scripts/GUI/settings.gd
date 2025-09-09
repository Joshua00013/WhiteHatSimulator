extends Control

signal BackButtonPressed



func _on_button_button_down():
	emit_signal("BackButtonPressed")
	if GameManager.ingame == false:
		get_tree().change_scene_to_file("res://Main Menu/main_menu.tscn")
