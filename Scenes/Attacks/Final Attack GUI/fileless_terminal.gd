extends MarginContainer

@onready var code_edit: CodeEdit = $HSplitContainer/CodeEdit
@onready var overlay: ColorRect = $HSplitContainer/CodeEdit/Overlay
@onready var desktop: MarginContainer = $"../Margin"
@onready var fileless: MarginContainer = $"."
@onready var rich_text_label: RichTextLabel = $HSplitContainer/HFlowContainer/RichTextLabel
@export var animation:AnimationPlayer

var step: int = 0

	
func _ready() -> void:
	animation.play("fileless_start")


func _on_back_button_down() -> void:
	# TODO: Set limits on back and next
	if step >= 1:
		step -= 1
		set_step(step)

func _on_next_button_down() -> void:
	step += 1
	set_step(step)

func set_step(step: int) -> void:
	match step:
		#Stsrt or MSFVENOM Start
		1:
			animation.play("fileless_1")
		2:
			animation.play("fileless_2")
		3:
			animation.play("fileless_3")
		4:
			animation.play("fileless_4")
		#APACHE
		5:
			animation.play("fileless_show_created_file")
			print("nigga")
		6:
			animation.play("animation_boilerplate_1")
		7:
			animation.play("animation_boilerplate_2")
		8:
			animation.play("animation_boilerplate_3")
		9:
			animation.play("animation_boilerplate_4")
		10:
			animation.play("animation_boilerplate_5")
		11:
			animation.play("animation_boilerplate_6")
		12:
			animation.play("animation_boilerplate_7")
		13:
			animation.play("fileless_show_created_file")
		14:
			animation.play("fileless_5")
		15:
			animation.play("fileless_6")
		16:
			animation.play("fileless_7")
		17:
			animation.play("fileless_8")
		18:
			animation.play("fileless_9")
		19:
			animation.play("fileless_10")
		20:
			animation.play("fileless_11")
		21:
			animation.play("fileless_12")
		22:
			animation.play("fileless_13")
		23:
			exit_ui()
			
func _on_button_button_down() -> void:
	if step >= 1:
		step -= 1
		set_step(step)
		
func exit_ui():
	match OS.get_name():
		"Android":
			GameManager.android_ui.visible = true #Change Android UI visibility to shown
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	GameManager.player.exit_tool_tip.visible = false
	GameManager.player_camera.current = true
	GameManager.ui_active = false
