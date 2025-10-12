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
	DayAndNightManager.set_initial_time()
	DayAndNightManager.active = false
