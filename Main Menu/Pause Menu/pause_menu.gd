extends ColorRect

@onready var animator: AnimationPlayer = $AnimationPlayer
@onready var player = get_node("../Player")
@onready var play_button = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/ResumeButton
@onready var quit_button = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/QuitButton
@onready var quit_options = $QuitOptions

func _ready() -> void:
	play_button.pressed.connect(unpause)
	
func unpause():
	animator.play("Unpause")
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func pause():
	animator.play("Pause")
	get_tree().paused = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_quit_button_button_down():
	quit_options.visible = true


func _on_quit_back_button_down():
	quit_options.visible = false


func _on_quit_to_desktop_button_down():
	get_tree().quit()


func _on_quit_to_menu_button_down():
	get_tree().change_scene_to_file("res://Main Menu/main_menu.tscn")
