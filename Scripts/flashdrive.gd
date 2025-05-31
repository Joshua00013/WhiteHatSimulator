extends Node3D

#@export var inventory : Inventory (Pwede din iadd sa global variable)
@export var itemRes : InvItem

func _on_interactable_interact_triggered() -> void:
	GameManager.add_item(itemRes)
	queue_free()
