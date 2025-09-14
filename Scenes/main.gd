extends Node3D

@export var corridor_door : Node3D

func _ready() -> void:
	Dialogic.signal_event.connect(_on_dialogic_signal)
	
	match OS.get_name():
		"Windows":
			#DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
			UiManager.popup.display_popup("Controls","Use the WASD keys to move and your mouse to look around")
		"Android":
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
			UiManager.popup.display_popup("Controls","Use the joystick to move and swipe to look around")
			
	DayAndNightManager.active = true
	DayAndNightManager.set_initial_time()
	
	ConfigFileHandler.apply_display_mode()
	
	Dialogic.VAR.reset()
	# TODO : re initialize inventory and dialogic here

func _on_dialogic_signal(argument: String):
	match argument:
		"corridor_unlocked":
			corridor_door.unlock()
			corridor_door.interactable.trigger()
			corridor_door.player_unlocked = true
