extends Node3D

@export var resource : InvItem

func _on_interactable_interact_triggered():
	CyberattackManager.reconnaissance_finished = true
	GameManager.item_stolen.emit()
	GameManager.add_item(resource)
	queue_free()
