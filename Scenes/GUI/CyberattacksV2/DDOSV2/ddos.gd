extends Control

signal ddos_finished

@onready var anim_player = $AnimationPlayer

var finished
var animations: PackedStringArray = []
var current_index := 0

func _ready():
	animations = anim_player.get_animation_list()
	if animations.size() > 0:
		anim_player.play(animations[current_index])

func _process(_delta):
	if not visible or animations.is_empty():
		return
	
	if Input.is_action_just_pressed("next_pressed") && finished == true:
		_play_next()

	elif Input.is_action_just_pressed("back_pressed"):
		_play_previous()

func _play_next():
	if current_index < animations.size() - 1:
		current_index += 1
		anim_player.play(animations[current_index])
		if animations[current_index] == "dos_01":
			await anim_player.animation_finished
			_play_next()
		elif animations[current_index] == "dos_02":
			await anim_player.animation_finished
			CyberattackManager.delivery_finished = true
			_play_next()
		elif animations[current_index] == "dos_02_attack":
			await anim_player.animation_finished
			CyberattackManager.exploitation_finished = true
			_play_next()
		elif animations[current_index] == "dos_03": # This animation calls _on_review_pressed() in the middle of the animations
			await anim_player.animation_finished
			CyberattackManager.command_and_control_finished = true
			GameManager.stage_finished = true
			ddos_finished.emit()
	else:
		if animations[current_index] == "reset":
			emit_signal("code_finished")

func _play_previous():
	if current_index > 0:
		current_index -= 1
		anim_player.play(animations[current_index])

func terminal_disable():
	finished = false
	
func terminal_enable():
	finished = true
	
func _on_loic_pressed() -> void:
	#if CyberattackManager.data_server_seen == false:
		#anim_player.play("dos_data_server_not _seen")
	#else:
		#_play_next()
	_play_next()
	
func _on_review_pressed():
	CyberattackManager.installation_finished = true
