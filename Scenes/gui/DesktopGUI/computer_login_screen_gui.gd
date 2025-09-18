extends Control

@export var username : String = ""
@export var password : String = ""

@export var username_box : LineEdit
@export var password_box : LineEdit
@export var error_message : Label

signal login_successful

func _on_confirm_pressed() -> void:
	print(username)
	print(password)
	
	if username == username_box.text && password == password_box.text:
		if CyberattackAdaptationManager.no_password_used == true:
			CyberattackAdaptationManager.no_password_used = false
		if CyberattackAdaptationManager.weak_passwords == true && CyberattackAdaptationManager.no_password_used == false:
			CyberattackAdaptationManager.weak_passwords = false
		login_successful.emit()
	else:
		error_message.text = "Incorrect Uername or Password"
		error_message.modulate =Color.RED
