extends Node3D


@export var green_keycard_item : InvItem
func _on_interactable_interact_triggered():
	GameManager.add_item(green_keycard_item)
	queue_free()
