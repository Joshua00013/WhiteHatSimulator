extends MarginContainer

@export var animation: AnimationPlayer
@onready var urlbar: TextEdit = $ColorRect/SearchBar/urlbar

var typing 
var search_active = false
var url_link = "https://www.pulseforge-studio.com"
var step: int = 0
var scene = 1

signal change_to_terminal
signal change_to_deployment

func _ready() -> void:
	_play_scene_animation()

func _on_search_icon_pressed() -> void:
	animation.play("phishing_desktop_3")

	
func _on_next_pressed() -> void:
	step += 1
	set_step(step)

func set_step(step: int) -> void:
	match step:
		1:
			emit_signal("change_to_terminal")
			scene += 1
			_play_scene_animation()
		2:
			animation.play("phishing_fake_website")
		3:
			animation.play("phishing_fake_website_2")
		4:
			emit_signal("change_to_deployment")

func _play_scene_animation() -> void:
	if scene == 1:
		animation.play("phishing_desktop_start")
	elif scene == 2:
		step += 1
		set_step(step)

func _on_option_button_item_selected(index: int) -> void: 
	if index == 0:
		animation.play("phishing_desktop_3")
		
