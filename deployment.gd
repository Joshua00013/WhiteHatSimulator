extends TabContainer

@export var animation: AnimationPlayer

signal delivery_finished

func _ready() -> void:
	animation.play("choices")


func _on_host_pressed() -> void:
	animation.play("host")

func _on_upload_button_pressed() -> void:
	animation.play("uploading")
	
func deployment_finished():
	emit_signal("delivery_finished")
