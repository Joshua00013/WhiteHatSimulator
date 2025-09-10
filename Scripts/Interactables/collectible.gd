extends Node3D

@export var resource : InvItem

func _on_interactable_interact_triggered():
	GameManager.item_stolen.emit()
	GameManager.add_item(resource)
	CyberattackManager.fileless_recon_finished = true
	queue_free()
