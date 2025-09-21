extends Control

signal ransomwareV2_decypt_finished

@onready var anim_player = $AnimationPlayer

var animations: PackedStringArray = []
var current_index := 0
var password_entered := false

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
@onready var decryptor_window: Control = $DecryptorWindow

func _play_next():
	if current_index < animations.size() - 1:
		current_index += 1
		if animations[current_index] == "ransomware_step_12":
			freeze_animations = true
			anim_player.play(animations[current_index])
			UiManager.next_button.hide()
			UiManager.back_button.hide()
			await password_check_component.correct_password
			current_index += 1
			anim_player.play(animations[current_index])
			freeze_animations = false
		else:
			anim_player.play(animations[current_index])
	else:
		if animations[current_index] == "reset":
			pass

func _play_previous():
	if current_index > 0:
		current_index -= 1
		anim_player.play(animations[current_index])


func _on_window_background_window_exited():
	emit_signal("code_finished")

func _on_window_background_correct_pass() -> void:
	ransomwareV2_decypt_finished.emit()


func _correct_password() -> void:
	ransomwareV2_decypt_finished.emit()
