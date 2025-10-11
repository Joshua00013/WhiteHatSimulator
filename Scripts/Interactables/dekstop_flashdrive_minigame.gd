extends Node3D

@onready var animation_player = $AnimationPlayer
@onready var flash_drive = $FlashDriveLowPoly

signal flashdrive_plugged

var minigame_active := false
var holding := false
var progress := 0.0
var sensitivity := 0.003
var flashdrive_starting_position := Vector3(0.686, 0.0, -0.996)
var last_mouse_x := 0.0

func _ready():
	flash_drive.hide()
	animation_player.animation_finished.connect(_on_animation_finished)

func start_minigame():
	flash_drive.position = flashdrive_starting_position
	flash_drive.hide()
	animation_player.play("start_minigame")
	minigame_active = true
	holding = false
	progress = 0.0

func _on_animation_finished(anim_name: String):
	if anim_name == "start_minigame" and minigame_active:
		flash_drive.show()
		animation_player.assigned_animation = "plug_flashdrive"
		animation_player.seek(0, true)
		last_mouse_x = get_viewport().get_mouse_position().x

func _process(_delta):
	if not minigame_active or animation_player.assigned_animation != "plug_flashdrive":
		return
	
	holding = Input.is_action_pressed("pinch") 

	if holding:
		var mouse_x = get_viewport().get_mouse_position().x
		var delta_x = (mouse_x - last_mouse_x) * sensitivity
		last_mouse_x = mouse_x

		progress = clamp(progress + delta_x, 0.0, animation_player.current_animation_length)
		animation_player.seek(progress, true)

		if progress >= animation_player.current_animation_length:
			end_minigame()
	else:
		last_mouse_x = get_viewport().get_mouse_position().x  # reset when not holding

func end_minigame():
	minigame_active = false
	holding = false
	animation_player.play_backwards("start_minigame")
	flashdrive_plugged.emit()

func remove_flashdrive():
	flash_drive.hide()
