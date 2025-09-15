extends MarginContainer

@export var animation: AnimationPlayer

func _ready() -> void:
	animation.play("results")
	


func _on_next_button_down() -> void:
	CyberattackManager.dos_ready = true
