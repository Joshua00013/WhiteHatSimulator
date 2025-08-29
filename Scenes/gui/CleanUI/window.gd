extends Control
@onready var windows_ui: Control = $"."

@export var textbox := TextEdit
@export var password_message := Label
@export var animation : = AnimationPlayer
@export var desktop := TabContainer
@export var decryptor_finish_button_window : Button

signal window_exited


func _on_exit_button_pressed() -> void:
	windows_ui.visible = false
	window_exited.emit()
	
func submit_password(password):
	if password == "WhiteHat":
		password_message.text = "Successful!"
		decryptor_finish_button_window.visible = true
		
		# TODO: Return the player back to the desktop after a few seconds using animation player
	else:
		password_message.text = "Incorrect Password!"

func _on_button_button_down() -> void:
	submit_password(textbox.text)
