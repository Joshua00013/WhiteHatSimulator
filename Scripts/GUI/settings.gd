extends Control

@export var hand_tracking : HBoxContainer
@export var display : HBoxContainer

@onready var handtracking_check_box = $PanelContainer/Settings/HandTracking/handtrackingCheckBox
@onready var display_options = $PanelContainer/Settings/Display/DisplayOptionButton
@onready var music_slider = $PanelContainer/Settings/Music/MusicSlider
@onready var sfx_slider = $PanelContainer/Settings/Sounds/SoundSlider

enum DisplayChoice {
	WINDOWED = 0,
	FULLSCREEN = 1,
	EXCLUSIVE = 2
}
func _ready():
	if OS.get_name() == "Android":
		hand_tracking.hide()
		display.hide()
	if OS.get_name() == "Windows":
		var video_settings = ConfigFileHandler.load_video_settings()
		if HandTrackerLauncher.check_hand_tracker() == false:
			handtracking_check_box.button_pressed = false
			hand_tracking.hide()
		if video_settings.has("display_mode"):
			match video_settings.display_mode:
				"windowed":
					display_options.selected = DisplayChoice.WINDOWED
				"fullscreen":
					display_options.selected = DisplayChoice.FULLSCREEN
				"exclusive":
					display_options.selected = DisplayChoice.EXCLUSIVE
					
		if video_settings.has("hand_tracking"):
			handtracking_check_box.button_pressed = video_settings.hand_tracking
			if handtracking_check_box.button_pressed && HandTrackerLauncher.check_hand_tracker() == true:
				HandTrackerServer.start_server()
				HandTrackerLauncher.launch_hand_tracker()
				
	var audio_settings = ConfigFileHandler.load_audio_settings()
	if audio_settings.has("music_volume"):
		music_slider.value = audio_settings.music_volume * 100
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(audio_settings.music_volume))
		
	if audio_settings.has("sfx_volume"):
		sfx_slider.value = audio_settings.sfx_volume * 100
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), linear_to_db(audio_settings.sfx_volume))


func _on_apply_pressed():
	print(handtracking_check_box.button_pressed)
	print(HandTrackerLauncher.check_hand_tracker())
	if handtracking_check_box.button_pressed == true && HandTrackerLauncher.check_hand_tracker() == true:
		HandTrackerServer.start_server()
		HandTrackerLauncher.launch_hand_tracker()
	elif handtracking_check_box.button_pressed == false:
		HandTrackerServer.stop_server()
		HandTrackerServer.send_to_python("exit")
	
	ConfigFileHandler.save_video_setting("hand_tracking", handtracking_check_box.button_pressed)
	
	match display_options.selected:
		DisplayChoice.WINDOWED:
			ConfigFileHandler.save_video_setting("display_mode", "windowed")
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		DisplayChoice.FULLSCREEN:
			ConfigFileHandler.save_video_setting("display_mode", "fullscreen")
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		DisplayChoice.EXCLUSIVE:
			ConfigFileHandler.save_video_setting("display_mode", "exclusive")
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	
	ConfigFileHandler.save_audio_setting("music_volume", music_slider.value / 100)
	ConfigFileHandler.save_audio_setting("sfx_volume", sfx_slider.value / 100)
	
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(music_slider.value / 100))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), linear_to_db(sfx_slider.value / 100))


func _on_cancel_pressed():
	hide()
