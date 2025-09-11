extends MarginContainer

var encrypted := false

signal cyberattack_selected(cyberattack)

func _ransomware_pressed():
	cyberattack_selected.emit("Ransomware")
	
func _bruteforce_pressed():
	cyberattack_selected.emit("Bruteforce")
	
func _phishing_pressed():
	cyberattack_selected.emit("Phishing")
	
func _fileless_pressed():
	cyberattack_selected.emit("Fileless")
	
func _dos_pressed():
	cyberattack_selected.emit("DenialOfService")
