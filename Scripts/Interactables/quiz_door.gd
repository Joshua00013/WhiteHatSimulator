extends Node3D

var quiz_ui : Control

func _on_interactable_interact_triggered():
	if GameManager.stage_finished == false:
		UiManager.popup.display_popup("STOP!","You can't leave until you finish your tasks")
	elif GameManager.stage_finished == true:
		show_quiz()
		
func show_quiz():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	UiManager.quiz_ui.show()
	UiManager.quiz_ui.start_quiz()
