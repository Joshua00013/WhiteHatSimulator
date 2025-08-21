extends MarginContainer

@onready var code_edit: CodeEdit = $CodeEdit
@onready var overlay: ColorRect = $CodeEdit/Overlay

var step: int = 0

func _on_back_button_down() -> void:
	# TODO: Set limits on back and next
	if step > 1:
		step -= 1
		set_step(step)

func _on_next_button_down() -> void:
	step += 1
	set_step(step)

func set_step(step: int) -> void:
	match step:
		1:
			code_edit.text = "This is step 1"
			# TODO: Adjust overlay.material dimensions accordingly here
		2:
			code_edit.text = "This is step 1\nThis is step 2"
