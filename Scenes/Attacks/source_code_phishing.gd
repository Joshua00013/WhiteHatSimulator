extends MarginContainer

@onready var overlay: ColorRect = $source_code_phishing/HSplitContainer/CodeEdit/Overlay

var step: int = 0

func _ready() -> void:
	overlay.visible = false
	
	
func _on_back_button_down() -> void:
	# TODO: Set limits on back and next
	if step >= 1:
		step -= 1
		set_step(step)

func _on_next_button_down() -> void:
	step += 1
	set_step(step)
	
func _update_shader(pos: Vector2, size: Vector2) -> void:
	if overlay.material is ShaderMaterial:
		var shader_mat := overlay.material as ShaderMaterial
		shader_mat.set_shader_parameter("hole_position", pos)
		shader_mat.set_shader_parameter("hole_size", size) 	

func set_step(step: int) -> void:
	match step:
