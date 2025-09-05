extends Node3D

@export var laptop : PackedScene

func _on_interactable_interact_triggered():
	pass # Replace with function body.

func spawn_laptop():
	var new_laptop = laptop.instantiate()
	add_child(new_laptop)
