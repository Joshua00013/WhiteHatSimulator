extends MarginContainer

@onready var code_edit: CodeEdit = $HSplitContainer/CodeEdit
@onready var overlay: ColorRect = $HSplitContainer/CodeEdit/Overlay

@onready var rich_text_label: RichTextLabel = $HSplitContainer/HFlowContainer/RichTextLabel
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
			rich_text_label.text = "This code demonstrates the logic of how malware infects a system. Let's explore and understand, line by line, how this code works."
			code_edit.text = "THIS IS LINE 1"
		2:
			rich_text_label.text = "This is step 1\nThis is step 2"
			code_edit.text = "This IS LINE 1\n THIS IS LINE 2"
			overlay.visible = true
