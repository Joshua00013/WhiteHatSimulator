extends CollisionObject3D

class_name Interactable

@export var prompt_message = "Interact"
signal interact_triggered

func trigger():
	emit_signal("interact_triggered")
