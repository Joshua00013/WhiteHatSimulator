extends Control

@export var player_label : Label

@onready var animation_player = $AnimationPlayer

@onready var day_1_score: Label = $ColorRect/Scores/Day1Score
@onready var day_2_score: Label = $ColorRect/Scores/Day2Score
@onready var day_3_score: Label = $ColorRect/Scores/Day3Score
@onready var day_4_score: Label = $ColorRect/Scores/Day4Score
@onready var day_5_score: Label = $ColorRect/Scores/Day5Score

# Called when the node enters the scene tree for the first time.
func _ready():
	SceneTransition.fade_out()
	update_scores()
	animation_player.play("ending")
	player_label.text = GameManager.player_name


func return_to_main():
	SceneTransition.fade_in()
	get_tree().change_scene_to_file("res://GUI/MainMenuUI/main_menu.tscn")

func update_scores():
	day_1_score.text += str(GameManager.day1_score)
	day_2_score.text += str(GameManager.day2_score)
	day_3_score.text += str(GameManager.day3_score)
	day_4_score.text += str(GameManager.day4_score)
	day_5_score.text += str(GameManager.day5_score)
