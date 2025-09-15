extends TabContainer

@export var animation: AnimationPlayer

signal delivery_finished
signal phishing_ready
func _ready() -> void:
	animation.play("choices")


func _on_host_pressed() -> void:
	animation.play("host")

func _on_upload_button_pressed() -> void:
	animation.play("uploading")
	
func deployment_finished():
	CyberattackManager.phishing_ready = true
	emit_signal("phishing_ready")
	
