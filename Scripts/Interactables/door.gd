extends Node3D

@onready var animation_player = $AnimationPlayer

var is_open := false

func _on_interactable_interact_triggered():
	if animation_player.is_playing():
		return
	
	if is_open == false:
		print("Opened")
		is_open = true
		animation_player.play("open")
	else:
		print("Closed")
		#is_open = false
		#animation_player.play("close")
