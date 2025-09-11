extends Node3D

@onready var interactable: Interactable = $Interactable
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var is_open := false

@export var flipped := false
@export var player_unlocked := false
@export var security_door := false
@export var locked : bool = false

func _ready() -> void:
	animation_player.animation_finished.connect(_on_animation_player_animation_finished)
	if locked:
		interactable.prompt_message = "Locked"

func _on_interactable_interact_triggered():
	if locked:
		return
	if animation_player.is_playing() && is_open == false:
		return
	
	if is_open == false:
		is_open = true
		if flipped:
			animation_player.play("open_flipped")
		else:
			animation_player.play("open")
	else:
		is_open = false
		if flipped:
			animation_player.play("close_flipped")
		else:
			animation_player.play("close")


func lock():
	if player_unlocked == false:
		locked = true
		interactable.prompt_message = "Locked"

func unlock():
	locked = false
	player_unlocked = true
	interactable.prompt_message = "Open"
	
func npc_unlock():
	locked = false
	interactable.prompt_message = "Open"

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "close" || anim_name == "close_flipped":
		if player_unlocked == false:
			print("LOCKED")
			lock()
