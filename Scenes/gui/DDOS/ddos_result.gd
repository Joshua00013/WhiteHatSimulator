extends MarginContainer

@export var animation: AnimationPlayer
signal dos_ready
func _ready() -> void:
	UiManager.nav_buttons_active = true
	animation.play("results")
	


func _on_next_button_down() -> void:
	CyberattackManager.dos_ready = true
	emit_signal("dos_ready")
