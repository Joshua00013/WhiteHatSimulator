extends Node

func _ready():
	SceneTransition.fade_out()
	MusicPlayer.play()
	ConfigFileHandler.apply_display_mode()
