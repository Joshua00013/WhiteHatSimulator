extends Control

signal code_finished

@onready var anim_player = $AnimationPlayer
@onready var password_check_component: Control = $WindowBackground/Window2/WindowContents/MarginContainer/PasswordCheckComponent

@export var rerun_btn : Button
@export var windows : ColorRect
@export var code_overlay : ColorRect

var animations: PackedStringArray = []
var current_index := 0
var password_entered := false
var freeze_animations := false

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
		if freeze_animations == true:
			freeze_animations = false
		_play_previous()

func _play_next():
	if current_index < animations.size() - 1:
		current_index += 1
		if animations[current_index] == "ransomware_step_12":
			freeze_animations = true
			anim_player.play(animations[current_index])
			UiManager.back_button.hide()
			UiManager.next_button.hide()
			await password_check_component.correct_password
			if current_index < animations.size() - 1:
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
		anim_player.play_backwards(animations[current_index])

func _on_button_pressed():
	current_index = 0
	anim_player.play("RESET")
	CyberattackManager.ransomware_ready = true
	emit_signal("code_finished")


func on_password_closed():
	code_overlay.hide()
	windows.hide()
	rerun_btn.show()


func _on_rerun_code_pressed():
	code_overlay.show()
	windows.show()
	rerun_btn.hide()
