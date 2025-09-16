extends Control

@export var hand_tracking : HBoxContainer
@export var display : HBoxContainer

@onready var handtracking_check_box = $NinePatchRect/Settings/HandTracking/handtrackingCheckBox
@onready var display_options = $NinePatchRect/Settings/Display/DisplayOptionButton
@onready var music_slider = $NinePatchRect/Settings/Music/MusicSlider
@onready var sfx_slider = $NinePatchRect/Settings/Sounds/SoundSlider

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
			if handtracking_check_box.button_pressed:
				HandTrackerServer.start_server()
				
	var audio_settings = ConfigFileHandler.load_audio_settings()
	if audio_settings.has("music_volume"):
		music_slider.value = audio_settings.music_volume * 100
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(audio_settings.music_volume))
		
	if audio_settings.has("sfx_volume"):
		sfx_slider.value = audio_settings.sfx_volume * 100
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), linear_to_db(audio_settings.sfx_volume))


func _on_apply_pressed():
	if handtracking_check_box.button_pressed == true:
		HandTrackerServer.start_server()
	elif handtracking_check_box.button_pressed == false:
		HandTrackerServer.stop_server()
	
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


func _on_cancel_pressed():
	hide()
