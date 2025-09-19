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
		if animations[current_index] == "phishing_01":
			SignalBus.phshing_terminal_to_desktop.emit()
		elif animations[current_index] == "phishing_10":
			CyberattackManager.phishing_ready = true
			emit_signal("code_finished")
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
	
	
