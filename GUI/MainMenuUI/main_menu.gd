extends Control

@export var animation:AnimationPlayer

func _ready():
	animation.play("main_menu_start")

func _on_start_pressed():
	animation.play("main_menu_clicked_start_new_game")
	#get_tree().change_scene_to_file("res://Scenes/main.tscn")

func _on_settings_pressed():
	get_tree().change_scene_to_file("res://Main Menu/mainMenu#2/Main_menu/settings.tscn")

func _on_exit_pressed():
	get_tree().quit()


func _on_button_4_button_down():
	get_tree().change_scene_to_file("res://Scenes/gui/load_menu.tscn")


func _on_fileless_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Stages/Fileless/stage_fileless.tscn")

func _on_phishing_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Stages/Phishing/stage_phishing.tscn")

func _on_denial_of_service_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Stages/DOS/stage_dos.tscn")
