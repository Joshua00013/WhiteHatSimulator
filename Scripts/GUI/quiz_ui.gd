extends CanvasLayer

@export var score_label : Label
@export var status : Label
@export var passing_score : int = 10
@onready var finished_window: Control = $FinishedWindow

func _on_quiz_card_quiz_finished(point_counter: int) -> void:
	finished_window.visible = true
	score_label.text = "Score" + str(point_counter)
	if point_counter < passing_score:
		status.text = "Failed"
	else:
		status.text = "Passed"
