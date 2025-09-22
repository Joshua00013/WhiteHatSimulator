extends Control

@export var player_label : Label
@onready var animation_player = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	player_label.text = GameManager.player_name
	await animation_player.animation_finished
	SceneTransition.fade_in()
	get_tree().change_scene_to_file("res://GUI/MainMenuUI/main_menu.tscn")
