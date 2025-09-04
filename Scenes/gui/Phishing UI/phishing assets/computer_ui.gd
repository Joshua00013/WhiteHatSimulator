extends Control


signal to_desktop

func _on_phishinh_pressed():
	emit_signal("to_desktop")
	print("I AM PRESSED")
