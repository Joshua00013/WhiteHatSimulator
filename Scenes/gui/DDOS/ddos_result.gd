extends MarginContainer

@export var animation: AnimationPlayer

func _ready() -> void:
	animation.play("results")
	
