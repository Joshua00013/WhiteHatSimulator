extends Area3D

var occupants : Array = []

func _ready() -> void:
	await get_tree().process_frame  # wait one frame
	get_initial_occupants()
	
	GameManager.connect("item_stolen",notify_room)

func _on_body_entered(body: Node3D) -> void:
	occupants.append(body)

func _on_body_exited(body: Node3D) -> void:
	occupants.erase(body)

func notify_room():
	if GameManager.player in occupants:
		for occupant in occupants:
			if occupant.is_in_group("npc"):
				occupant.change_state(occupant.WorkState.CHASE)

func get_initial_occupants():
	for body in get_overlapping_bodies():
		if body is Node3D:
			occupants.append(body)
