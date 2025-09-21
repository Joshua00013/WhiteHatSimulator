extends Node3D

@export var corridor_door : Node3D

func _ready() -> void:
	MusicPlayer.stream = load("res://Assets/Audio/UhOh.mp3")
	MusicPlayer.play()
	SceneTransition.fade_out()
	
	Dialogic.signal_event.connect(_on_dialogic_signal)
	DayAndNightManager.time_tick_hour.connect(validate_time)
	
	match DayAndNightManager.initial_day:
		1: # If on day 1, display the tooltips etc.
			match OS.get_name():
				"Windows":
					#DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
					UiManager.popup.display_popup("Controls","Use the WASD keys to move and your mouse to look around")
				"Android":
					UiManager.popup.display_popup("Controls","Use the joystick to move and swipe to look around")
		2:
			UiManager.popup.display_popup("Congratulations!", "You are now at your second day. You unlocked a new cyberattack, but you need a flashdrive to deploy it.")
		3:
			UiManager.popup.display_popup("Great job!","There are reports stating that some employees don't update their antivirus. Do an penetration testing as usual")
			#TODO: Add day specific messages here
	if OS.get_name() == "Android": # Change this to a default display setting for android
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	
	DayAndNightManager.active = true
	DayAndNightManager.set_initial_time()
	CyberattackAdaptationManager.save_snapshot() # Save the values at the start of the day to be used for resets
	ConfigFileHandler.apply_display_mode()
	Dialogic.VAR.reset()

func _on_dialogic_signal(argument: String):
	match argument:
		"corridor_unlocked":
			corridor_door.unlock()
			corridor_door.interactable.trigger()
			corridor_door.player_unlocked = true

func validate_time(hour: int):
	var time_out_hour = 18
	if hour == time_out_hour:
		UiManager.game_over_ui.play("You ran out of time, the employees are leaving")
