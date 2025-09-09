extends Control

@export var password_box : TextEdit
@export var message_label : Label

var password : String = "WhiteHat"
var input_pass : String

signal correct_password

func _on_ransomware_decrypt_submit_button_pressed() -> void:
	input_pass = password_box.text
	if input_pass == password:
		correct_password.emit()
	else:
		message_label.text = "Incorrect Password"
