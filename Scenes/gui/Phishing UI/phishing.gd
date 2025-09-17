extends MarginContainer

@export var animation: AnimationPlayer
var step: int = 0
var scene = 1
signal change_to_website

func _ready() -> void:
	_play_scene_animation()
	
	
func _process(_delta: float) -> void:
	if visible:
		if Input.is_action_just_pressed("next_pressed"):
			step += 1
			set_step(step)

		elif Input.is_action_just_pressed("back_pressed"):
			if step != 0 && step != 6 && step != 13 && step != 7 && step != 14:
				step -= 1
				set_step(step)
			elif step == 0:
				animation.play("start_of_fileless")
			elif step == 7:
				step -= 1
				animation.play("fileless_boilerplate_1")
			elif step == 14:
				step -= 1
				animation.play("fileless_listener_1")
	
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
