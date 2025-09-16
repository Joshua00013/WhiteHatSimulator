extends Node3D

@onready var animation_player = $AnimationPlayer  # only for camera
@onready var flash_drive = $FlashDriveLowPoly

var minigame_active: bool = false
var sensitivity: float = 0.01  # horizontal movement sensitivity
var delta_x: float = 0.0
var flashdrive_starting_position :Vector3 = Vector3(0.686,0.0,-0.996)
signal flashdrive_plugged

func _ready():
	flash_drive.hide()
	animation_player.animation_finished.connect(_on_animation_finished)

func start_minigame():
	flash_drive.position = flashdrive_starting_position
	holding = false
	hold_start_x = 0
	minigame_active = true
	animation_player.play("start_minigame")  # camera animation

func _on_animation_finished(anim_name: String):
	print("animation done")
	if anim_name == "start_minigame" and minigame_active:
		flash_drive.show()
		animation_player.assigned_animation = "plug_flashdrive"

var hold_start_x: float = 0.0
var holding: bool = false

func _input(event):
	# Detect hold start
	if animation_player.assigned_animation != "plug_flashdrive":
		return
	if Input.is_action_just_pressed("hold"):
		holding = true
		# Store the current mouse/touch X as reference
		if event is InputEventMouse or event is InputEventScreenTouch:
			hold_start_x = event.position.x

	# Detect hold release
	if Input.is_action_just_released("hold"):
		holding = false
	
	
	var minigame_length = animation_player.current_animation_length
	# Use the stored position for movement
	if holding and event is InputEventMouseMotion:
		delta_x = event.position.x - hold_start_x
		delta_x /= 100
		animation_player.seek(delta_x,true)
		if delta_x >= minigame_length:
			delta_x = 0
			end_minigame()

func end_minigame():
	minigame_active = false
	animation_player.seek(0,false)
	animation_player.play_backwards("start_minigame")
	flashdrive_plugged.emit()
	
func remove_flashdrive():
	flash_drive.hide()
