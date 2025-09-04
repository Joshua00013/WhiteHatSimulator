extends Control

@export var username : String = ""
@export var password : String = ""

@export var username_box : LineEdit
@export var password_box : LineEdit
@export var error_message : Label

func _on_confirm_pressed() -> void:
	print("Username:", username_box.text)#Tester Only if button is functionings functioning
	print("Password:", password_box.text)#Tester Only if button is functionings functioning

	if username == username_box.text && password == password_box.text:
		get_tree().change_scene_to_file("")
	else:
		error_message.text = "Incorrect Uername or Password"
		error_message.modulate =Color.RED
