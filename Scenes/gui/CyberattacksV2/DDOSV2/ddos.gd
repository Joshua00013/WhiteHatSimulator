extends Control

signal code_finished

@onready var anim_player = $AnimationPlayer

var animations: PackedStringArray = []
var current_index := 0

func _ready():
	animations = anim_player.get_animation_list()
	if animations.size() > 0:
		anim_player.play(animations[current_index])

func _process(_delta):
	if not visible or animations.is_empty():
		return
	
	if Input.is_action_just_pressed("next_pressed"):
		if CyberattackManager.website_seen == false:
			anim_player.play("dos_website_not_seen")
		else:
			if animations[current_index] == "dos_17":
				CyberattackManager.exploitation_finished = true
				_play_next()
			elif animations[current_index] == "dos_18_attack":
				CyberattackManager.installation_finished = true
				CyberattackManager.command_and_control_finished = true
			else:
				_play_next()

	elif Input.is_action_just_pressed("back_pressed"):
		_play_previous()

func _play_next():
	if current_index < animations.size() - 1:
		current_index += 1
		anim_player.play(animations[current_index])
	else:
		if animations[current_index] == "reset":
			emit_signal("code_finished")

func _play_previous():
	if current_index > 0:
		current_index -= 1
		anim_player.play(animations[current_index])


func _on_loic_pressed() -> void:
	_play_next()
	
