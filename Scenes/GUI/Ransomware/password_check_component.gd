extends Control

@export var password_box : LineEdit
@export var message_label : Label

var password : String = "WhiteHat"
var input_pass : String

signal correct_password
signal ransomware_decrypt_finished

func _on_ransomware_decrypt_submit_button_pressed() -> void:
	input_pass = password_box.text
	if input_pass == password:
		correct_password.emit()
	else:
		message_label.text = "Incorrect Password, READ THE CODE!"

func _on_password_check_component_correct_password() -> void:
	CyberattackManager.ransomware_ready = true
	ransomware_decrypt_finished.emit()
