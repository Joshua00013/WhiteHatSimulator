extends Control

var username
var password 

func _on_confirm_pressed() -> void:
	print("Username:", $Username.text)#Tester Only if button is functionings functioning
	print("Password:", $Password.text)#Tester Only if button is functionings functioning

	username = ""#variable for unique 
	password = ""

	if username == $Username.text && password == $Password.text:
		
		get_tree().change_scene_to_file("")
	else:
		$Warning_label.text = "Incorrect Uername or Password"
		$Warning_label.modulate =Color.RED
