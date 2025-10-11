extends Control

@onready var anim_player = $AnimationPlayer
@onready var exit_button: TextureButton = $"WindowContainer/Terminal/generating exe/HBoxContainer/ExitButton"
@onready var terminal_1: VBoxContainer = $Desktop/terminal1

var animations: PackedStringArray = []
var current_index := 0
var waiting_for_finish := false

func _ready():
	exit_button.disabled = true
	animations = anim_player.get_animation_list()
	if animations.size() > 0:
		anim_player.play(animations[current_index])

func _process(_delta):
	if not visible or animations.is_empty():
		return
	
	if Input.is_action_just_pressed("next_pressed"):
		if animations[current_index] in ["fileless_01", "fileless_10", "fileless_13"]:
			if not waiting_for_finish:
				waiting_for_finish = true
				_handle()
		elif animations[current_index] in ["fileless_20", "fileless_28"]:
			if not waiting_for_finish:
				waiting_for_finish = true
				_handle()
				
		else:
			_play_next()
	elif Input.is_action_just_pressed("back_pressed"):
		if animations[current_index] == "fileless_21":
			return
		else:
			_play_previous()

func _play_next():
	if current_index < animations.size() - 1:
		current_index += 1
		anim_player.play(animations[current_index])
	else:
		if animations[current_index] == "reset":
			current_index = 0
			anim_player.play("RESET")

func _play_previous():
	if current_index > 0:
		current_index -= 1
		anim_player.play(animations[current_index])

func _handle() -> void:
	if anim_player.is_playing():
		await anim_player.animation_finished
	waiting_for_finish = false
	if animations[current_index] in ["fileless_20", "fileless_28"]:
		SignalBus.fileless_part2_finished.emit()
	_play_next()
