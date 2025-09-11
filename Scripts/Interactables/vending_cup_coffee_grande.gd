extends Node3D

@export var resource : InvItem

func _on_interactable_interact_triggered():
	print(resource)
	Dialogic.VAR.has_coffee = true
	GameManager.add_item(resource)
	queue_free()
