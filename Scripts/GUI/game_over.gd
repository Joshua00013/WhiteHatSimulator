extends Control

var default_message = "You have been caught"

@onready var body = $PanelContainer/VBoxContainer/Body

func _ready():
	UiManager.game_over_ui = self
	visible = false

func play(message : String = default_message):
	body.text = message
	
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().paused = true
	visible = true

func _on_button_pressed():
	GameManager.reset()
	CyberattackManager.reset()
	DayAndNightManager.set_initial_time()
	
	get_tree().paused = false
	get_tree().reload_current_scene()
