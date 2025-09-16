extends CanvasLayer

@onready var animation_player = $AnimationPlayer

signal transition_finished

func fade_in():
	animation_player.play("transition")
	await animation_player.animation_finished
	transition_finished.emit()
	
func fade_out():
	animation_player.play_backwards("transition")
	await animation_player.animation_finished
	transition_finished.emit()
