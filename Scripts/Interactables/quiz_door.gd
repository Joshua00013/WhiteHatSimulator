extends Node3D

@export var quiz_ui : CanvasLayer
# Called when the node enters the scene tree for the first time.
func _ready():
	quiz_ui.hide()

func _on_interactable_interact_triggered():
	if GameManager.stage_finished == false:
		UiManager.popup.display_popup("STOP!","You can't leave until you finish your tasks")
	else:
		show_quiz()
		
func show_quiz():
	quiz_ui.show()
	quiz_ui.start_quiz()
