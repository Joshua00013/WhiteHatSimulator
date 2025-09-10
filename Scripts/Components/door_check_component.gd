extends Area3D
func _on_area_entered(area: Area3D) -> void:
	var parent = area.get_parent()
	
	if parent.is_open == false && parent.security_door == true: #Handling of security doors/locked doors
		parent.locked = false #Unlock the door before opening
		area.trigger()
	elif parent.is_open == false:
		area.trigger()

func _on_area_exited(area: Area3D) -> void:
	var parent = area.get_parent()
	
	if parent.is_open == true && parent.security_door == true: #Handling of security doors/locked doors
		area.trigger()
		#parent.locked = true #Lock after door leaves the area
	elif parent.is_open == true:
		area.trigger()
