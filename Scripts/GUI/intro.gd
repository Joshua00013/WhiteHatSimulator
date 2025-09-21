extends Control

@onready var animation_player = $AnimationPlayer

func _on_animation_player_animation_finished(anim_name):
	SignalBus.intro_finished.emit()

func _input(event):
	if event.is_action_pressed("exit_ui"):
		if animation_player.is_playing():
			animation_player.seek(animation_player.current_animation_length, true) # Skip to the end
			SignalBus.intro_finished.emit()
