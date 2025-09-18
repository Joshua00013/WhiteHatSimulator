extends MarginContainer

var encrypted := false
@export var shader: ColorRect
@export var cards_container: ScrollContainer

func _ransomware_pressed():
	SignalBus.cyberattack_selected.emit("Ransomware")
	
func _bruteforce_pressed():
	SignalBus.cyberattack_selected.emit("Bruteforce")
	
func _phishing_pressed():
	SignalBus.cyberattack_selected.emit("Phishing")
	
func _fileless_pressed():
	SignalBus.cyberattack_selected.emit("Fileless")
	
func _dos_pressed():
	SignalBus.cyberattack_selected.emit("DOS")

func hide_cards():
	shader.hide()
	cards_container.hide()
	
func show_cards():
	shader.show()
	cards_container.show()
