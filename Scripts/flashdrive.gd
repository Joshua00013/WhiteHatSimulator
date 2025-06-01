extends Node3D

#@export var inventory : Inventory (Pwede din iadd sa global variable)
#@export var itemRes : Collectible (Contains descriptions, item name)

func _on_interactable_interact_triggered() -> void:
	#Inventory.add(itemRes)
	queue_free()
