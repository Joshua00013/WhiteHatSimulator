extends Area3D
# TODO: Cleanup the code for handling the security doors.
func _on_area_entered(area: Area3D) -> void:
	if area.get_parent().is_open == false && area.get_parent().security_door == true: #Handling of security doors/locked doors
		area.get_parent().locked = false #Unlock the door before opening
		area.trigger()
	elif area.get_parent().is_open == false:
		area.trigger()

func _on_area_exited(area: Area3D) -> void:
	if area.get_parent().is_open == true && area.get_parent().security_door == true: #Handling of security doors/locked doors
		area.trigger()
		area.get_parent().locked = true #Lock after door leaves the area
	elif area.get_parent().is_open == true:
		area.trigger()
