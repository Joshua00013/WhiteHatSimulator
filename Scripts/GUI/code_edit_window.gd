extends ColorRect

signal window_exited

func _on_button_pressed():
	get_tree().paused = false
	window_exited.emit()
	hide()
	
func display_window(): # The moment you show this window, the animations will wait until the player closes it. 
	get_tree().paused = true
