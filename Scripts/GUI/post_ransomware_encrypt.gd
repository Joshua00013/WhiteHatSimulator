extends MarginContainer

signal post_ransomware_encrypt_exited

@export var message : PanelContainer
@export var animation : AnimationPlayer

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("next_pressed") && visible:
		post_ransomware_encrypt_exited.emit()

func _on_button_pressed() -> void:
	post_ransomware_encrypt_exited.emit()

func _input(event):
	if event is InputEventMouseButton && event.pressed && animation.is_playing() == false && message.visible:
		animation.play("hide_message")


func _on_visibility_changed():
	if visible == true:
		animation.play("show_message")
