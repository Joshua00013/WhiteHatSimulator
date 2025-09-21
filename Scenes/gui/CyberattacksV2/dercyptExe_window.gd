extends ColorRect

signal decr_window_finished

func _on_button_pressed():
	get_tree().paused = false
	hide()
	decr_window_finished.emit()
	
func display_window(): # The moment you show this window, the animations will wait until the player closes it. 
	get_tree().paused = true
