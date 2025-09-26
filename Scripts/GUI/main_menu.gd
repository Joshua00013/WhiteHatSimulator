extends Node

func _ready():
	SceneTransition.fade_out()
	ConfigFileHandler.apply_display_mode()
