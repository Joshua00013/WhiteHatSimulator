extends MarginContainer

@onready var code_edit: CodeEdit = $HSplitContainer/CodeEdit
@onready var overlay: ColorRect = $HSplitContainer/CodeEdit/Overlay
@onready var desktop: MarginContainer = $"../Margin"
@onready var fileless: MarginContainer = $"."
@onready var rich_text_label: RichTextLabel = $HSplitContainer/HFlowContainer/RichTextLabel


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
		#Stsrt or MSFVENOM Start
		1:
			_update_shader(Vector2(0.115, .97), Vector2(3.3, 0.17))
			rich_text_label.text = "Hides the console window so the program runs silently. \n\n If SW_SHOW is used instead, the window would remain visible. "
			overlay.visible = true
		2:
			_update_shader(Vector2(0.115, 1.3), Vector2(3.3, 0.17))
			rich_text_label.text = "Downloads data from the URL using the CPR library. \n\n The shellcode is expected to be hosted at this address."
		3:
			_update_shader(Vector2(0.115, 1.47), Vector2(3.3, 0.34))
			rich_text_label.text = "Points memBuffer to the downloaded text content. \n\n Converts it into a raw C-style pointer for processing."
		4:
			_update_shader(Vector2(0.115, 1.93), Vector2(3.3, 0.17))
			rich_text_label.text = "Creates an array to hold 382 bytes of actual machine code (the payload)."
		5:
			_update_shader(Vector2(0.115, 2.1), Vector2(3.3, .9))
			rich_text_label.text = "Skips the first two characters of the text (likely formatting such as 0x). \n\nReads two hex digits at a time from memBuffer and converts them to a byte. \n\nStores each byte into the shellcode array.\n\nMoves the pointer forward by 4 characters each loop because the text format likely uses /x??. "
