extends Node

@export var ransomware_btn : Button
@export var bruteforce_btn : Button
@export var fileless_btn : Button

@export var deployment_animation: AnimationPlayer
@export var deployment_choice : Control
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
			if CyberattackManager.bruteforce_ready:
				bruteforce_btn.show()
		"fileless":
			fileless_btn.disabled = not CyberattackManager.fileless_ready

# TODO: Animations for deploying on pc
func _on_ransomware_pressed():
	deployment_choice.hide()
	CyberattackManager.exploitation_finished = true
	deployment_animation.play("execute_cyberattack")
	await deployment_animation.animation_finished
	if not CyberattackAdaptationManager.antivirus_installed:
		CyberattackManager.installation_finished = true
		deployment_animation.play("play_ransomware")
		await deployment_animation.animation_finished
		CyberattackManager.command_and_control_finished = true
		
		if CyberattackAdaptationManager.no_password_used == true:
			CyberattackAdaptationManager.no_password_used = false
		elif CyberattackAdaptationManager.weak_passwords == true:
			CyberattackAdaptationManager.weak_passwords = false
			
		GameManager.stage_finished = true
		CyberattackAdaptationManager.antivirus_installed = true
	elif CyberattackAdaptationManager.antivirus_installed:
		deployment_animation.play("play_ransomware_fail")
		await deployment_animation.animation_finished
		UiManager.popup.display_popup("Installation failed", "It seems that this PC has an antivirus, you should use a better cyberattack", false)


func _on_fileless_pressed():
	deployment_choice.hide()
	CyberattackManager.exploitation_finished = true
	deployment_animation.play("execute_cyberattack")
	await deployment_animation.animation_finished
	
	if not CyberattackAdaptationManager.antivirus_updated:
		# Play successful installation here
		CyberattackManager.installation_finished = true
		
	elif CyberattackAdaptationManager.antivirus_updated:
		#TODO : Add animation of fileless failing
		UiManager.popup.display_popup("Installation failed", "It seems that this PC has an up-to-date antivirus, you should use a different approach", false)

func _on_bruteforce_pressed():
	bruteforce_btn.hide()
	CyberattackManager.exploitation_finished = true
	deployment_animation.play("execute_bruteforce")

func _on_bruteforce_finished():
	if CyberattackAdaptationManager.weak_passwords == true:
		CyberattackManager.installation_finished = true
		CyberattackManager.command_and_control_finished = true
		
		if CyberattackAdaptationManager.weak_passwords == false:
			UiManager.popup.display_popup("Bruteforce failed", "It seems that this PC has a strong password, you should use a different approach", false)
		else:
			$"../Model/SubViewport/TabContainer/Login/Window/CodeEdit".text = "Password: " + str(get_parent().login_screen.password)
			CyberattackAdaptationManager.bruteforce_used = true
			UiManager.popup.display_popup("Bruteforce Successful!","You have found the password", false )
