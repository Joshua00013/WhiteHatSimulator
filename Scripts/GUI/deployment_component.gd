extends Node

@export var ransomware_btn : Button
@export var bruteforce_btn : Button
@export var fileless_btn : Button

@export var deployment_animation: AnimationPlayer

func _ready():
	bruteforce_btn.hide()
	
	ransomware_btn.disabled = true
	fileless_btn.disabled = true
	
	CyberattackManager.cyberattack_ready.connect(update_buttons)

func update_buttons(attack_name):
	match attack_name:
		"ransomware":
			ransomware_btn.disabled = not CyberattackManager.ransomware_ready
		"bruteforce":
			bruteforce_btn.visible = CyberattackManager.bruteforce_ready
		"fileless":
			fileless_btn.disabled = not CyberattackManager.fileless_ready


func _on_ransomware_pressed():
	pass # Replace with function body.


func _on_fileless_pressed():
	pass # Replace with function body.


func _on_bruteforce_pressed():
	pass # Replace with function body.
