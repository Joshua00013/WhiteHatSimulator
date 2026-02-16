extends Node

func _ready():
	MusicPlayer.stream = load("res://Assets/Audio/Eden_Flavor.mp3")
	SceneTransition.fade_out()
	MusicPlayer.play()
	ConfigFileHandler.apply_display_mode()
	
	GameManager.reset()
	CyberattackManager.reset()
	CyberattackAdaptationManager.reset()
	SignalBus.stage_finished.emit()
	DayAndNightManager.active = false
	DayAndNightManager.set_initial_time()
	DayAndNightManager.initial_day = 1
	
