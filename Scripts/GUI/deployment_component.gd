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

# TODO: Animations for deploying on pc
func _on_ransomware_pressed():
	CyberattackManager.exploitation_finished = true
	if not CyberattackAdaptationManager.antivirus_installed:
		# Play successful installation here and wait until it finishes
		CyberattackManager.installation_finished = true
		pass
	elif CyberattackAdaptationManager.antivirus_installed:
		pass
		# Play unsuccessful isntallation here


func _on_fileless_pressed():
	CyberattackManager.exploitation_finished = true
	if not CyberattackAdaptationManager.antivirus_updated:
		# Play successful installation here
		CyberattackManager.installation_finished = true
		pass
	elif CyberattackAdaptationManager.antivirus_updated:
		pass
		# Play unsuccessful installation here

func _on_bruteforce_pressed():
	CyberattackManager.exploitation_finished = true
	if CyberattackAdaptationManager.weak_passwords == true:
		# Play unsuccessful installation here
		pass
