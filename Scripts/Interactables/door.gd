extends Node3D

@onready var interactable: Interactable = $Interactable
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var is_open := false

@export var player_unlocked := false
@export var security_door := false
@export var locked : bool = false

func _ready() -> void:
	if locked:
		interactable.prompt_message = "Locked"

func _on_interactable_interact_triggered():
	if locked && player_unlocked == false:
		#TODO: Add a message saying door is locked
		return
	
	if animation_player.is_playing():
		return
	
	if is_open == false:
		is_open = true
		animation_player.play("open")
	else:
		is_open = false
		animation_player.play("close")
		lock()

func lock():
	if player_unlocked == false:
		locked = true
		interactable.prompt_message = "Locked"
