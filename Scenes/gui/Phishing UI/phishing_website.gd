extends MarginContainer

@export var animation: AnimationPlayer
@onready var urlbar: TextEdit = $ColorRect/SearchBar/urlbar

var url_link = "https://www.pulseforge-studio.com"
var step: int = 0
var scene = 1
signal change_to_terminal

func _ready() -> void:
	_play_scene_animation()

func _on_search_pressed() -> void:
	if urlbar.text == url_link:
		step += 1
		set_step(step)
	else:
		if urlbar.text != url_link:
			animation.play("wrong_url")
	
func _on_next_pressed() -> void:
	step += 1
	set_step(step)

func set_step(step: int) -> void:
	match step:
		1:
			animation.play("phishing_desktop_2")
		2:
			animation.play("phishing_desktop_3")
		3:
			emit_signal("change_to_terminal")
			_play_scene_animation()
			scene += 1
		4:
			animation.play("phishing_fake_website")
		5:
			animation.play("phishing_fake_website_2")
func _play_scene_animation() -> void:
	if scene == 1:
		animation.play("phishing_desktop_start")
	elif scene == 2:
		step += 1
		set_step(step)
