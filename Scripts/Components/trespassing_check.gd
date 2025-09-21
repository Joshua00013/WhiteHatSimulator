extends Area3D

func _on_body_entered(body):
	GameManager.player.trespassing = true

func _on_body_exited(body):
	GameManager.player.trespassing = false
