extends Control

@export var score_label : Label
@export var status : Label
@export var passing_score : int = 5
@export var quiz_card : Control

@onready var finished_window: Control = $FinishedWindow

func _ready():
	UiManager.quiz_ui = self
	hide()

func _on_quiz_card_quiz_finished(point_counter: int) -> void:
	# TODO : Code cleanup and remove finished window
	#finished_window.visible = true
	#score_label.text = "Score" + str(point_counter)
	
	if point_counter < passing_score:
		#status.text = "Failed"
		UiManager.game_over_ui.play()
	else:
		#status.text = "Passed"
		UiManager.popup.display_popup("Passed","Take a rest and proceed to your next day!")
		
		# Reinitialize the stage and increment the days
		DayAndNightManager.initial_day += 1
		SignalBus.stage_finished.emit()
		GameManager.reset()
		GameManager.ui_active = false
		CyberattackManager.reset()
		DayAndNightManager.set_initial_time()
		get_tree().reload_current_scene()

func start_quiz():
	GameManager.ui_active = true
	quiz_card.start_quiz()
