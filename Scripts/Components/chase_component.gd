extends Area3D

@onready var collision_shape_3d = $CollisionShape3D

func _ready():
	disable_chase()

func disable_chase():
	collision_shape_3d.disabled = true

func enable_chase():
	collision_shape_3d.disabled = false

func _on_body_entered(body):
	UiManager.game_over_ui.play()
