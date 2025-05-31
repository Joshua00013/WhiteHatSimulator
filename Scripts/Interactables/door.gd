extends Node3D

var is_open := false

func _on_interactable_interact_triggered():
	if is_open == false:
		rotate_y(90)
		is_open = true
	else:
		rotate_y(-90)
		is_open = false
