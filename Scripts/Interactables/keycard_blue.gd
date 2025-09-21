extends Node3D

@export var blue_keycard_item : InvItem

func _on_interactable_interact_triggered():
	GameManager.add_item(blue_keycard_item)
	queue_free()
