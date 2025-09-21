extends Control

signal decrytv2_finished


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
		_play_next()
	elif Input.is_action_just_pressed("back_pressed"):
		_play_previous()
		
@export var decryptor_window: Control 
func _play_next():
	if  current_index < animations.size() - 1:
		current_index += 1
		anim_player.play(animations[current_index])	
		if current_index == 13:
			decryptor_window.visible = true
	else:
		if animations[current_index] == "reset":
			emit_signal("code_finished")

func _play_previous():
	if current_index > 0:
		current_index -= 1
		anim_player.play(animations[current_index])

func _correct_password() -> void:
	CyberattackManager.ransomware_ready = true
	decrytv2_finished.emit()

func _on_malware_exe_window_decr_window_finished() -> void:
	$DecryptorWindow.visible = true
	
func _on_decryptor_window_decryptor_window_finished() -> void:
	decrytv2_finished.emit()
