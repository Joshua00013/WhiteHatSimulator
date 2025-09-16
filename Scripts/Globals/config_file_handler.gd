extends Node

var config = ConfigFile.new()
const CONFIG_FILE_PATH = "user://settings.ini"

func _ready():
	if !FileAccess.file_exists(CONFIG_FILE_PATH):
		config.set_value("video", "hand_tracking", false)
		config.set_value("video", "fullscreen", true)
		
		config.set_value("audio", "music_volume", 1.0)
		config.set_value("audio", "sfx_volume", 1.0)
		
		config.save(CONFIG_FILE_PATH)
	else:
		config.load(CONFIG_FILE_PATH)

func save_video_setting(key: String, value):
	config.set_value("video", key, value)
	config.save(CONFIG_FILE_PATH)

func load_video_settings():
	var video_settings = {}
	for key in config.get_section_keys("video"):
		video_settings[key] = config.get_value("video",key)
	return video_settings

func save_audio_setting(key: String, value):
	config.set_value("audio",key,value)
	config.save(CONFIG_FILE_PATH)

func load_audio_settings():
	var audio_settings = {}
	for key in config.get_section_keys("audio"):
		audio_settings[key] = config.get_value("audio",key)
	return audio_settings

func apply_display_mode() -> void:
	var video_settings = ConfigFileHandler.load_video_settings()
	if not video_settings.has("display_mode"):
		return
	
	match video_settings.display_mode:
		"windowed":
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		"fullscreen":
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		"exclusive":
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
