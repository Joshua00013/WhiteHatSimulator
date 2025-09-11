extends MarginContainer

@export var animation: AnimationPlayer
var step: int = 0
var scene = 1
signal change_to_website

func _ready() -> void:
	_play_scene_animation()
	
	
func _on_next_pressed() -> void:
	step += 1
	set_step(step)
	
func set_step(step: int) -> void:
	match step:
		1:
			emit_signal("change_to_website")
			scene += 1
			_play_scene_animation()
		2:
			animation.play("phishing_1")
		3:
			animation.play("phishing_2")
		4:
			animation.play("phishing_3")
		5:
			animation.play("phishing_4")
		6:
			emit_signal("change_to_website")
			
func _play_scene_animation() -> void:
	if scene == 1:
		animation.play("start_of_phishing")
	elif scene == 2:
		step += 1
		set_step(step)
