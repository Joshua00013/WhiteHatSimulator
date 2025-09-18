extends Control

signal code_finished
signal change_desktop

@onready var anim_player = $AnimationPlayer

var animations: PackedStringArray = ["fileless_1", "fileless_2", "fileless_3", "fileless_4", "fileless_5", "fileless_6", "fileless_7", "fileless_8", "fileless_9", "fileless_10", "fileless_11", "fileless_12", "fileless_13", "fileless_14", "fileless_15", "fileless_16", "fileless_17", "fileless_18"]

var current_index := 0

func _ready():
	print(anim_player.get_animation_list())
	animations = anim_player.get_animation_list()
	if animations.size() > 0:
		anim_player.play(animations[current_index])

func _process(_delta):
	if not visible or animations.is_empty():
		return

	if Input.is_action_just_pressed("next_pressed"):
		print(animations[current_index])
		if animations[current_index] == "fileless_1":
			SignalBus.emit_signal("change_website")
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
