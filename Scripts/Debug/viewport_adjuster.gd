extends CanvasLayer

@export var subviewport : SubViewport

func _on_button_pressed() -> void:
	subviewport.size.x += 10


func _on_button_2_pressed() -> void:
	subviewport.size.x -= 10


func _on_button_3_pressed() -> void:
	subviewport.size.y += 10
	print(subviewport.size.y)


func _on_button_4_pressed() -> void:
	subviewport.size.y -= 10
	print(subviewport.size.y)


func _on_return_button_pressed():
	Input.action_press("exit_ui")
	Input.action_release("exit_ui")
