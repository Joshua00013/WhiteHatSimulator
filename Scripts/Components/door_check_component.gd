extends Area3D

@onready var timer: Timer = $Timer

func _on_area_entered(area: Area3D) -> void:
	if area.get_parent().is_open == false:
		area.trigger()

func _on_area_exited(area: Area3D) -> void:
	if area.get_parent().is_open == true:
		area.trigger()
