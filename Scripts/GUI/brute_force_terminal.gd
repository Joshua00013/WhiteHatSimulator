extends MarginContainer
@export var animation: AnimationPlayer

func _ready() -> void:
	animation.play("Brute_force_running_terminal")
