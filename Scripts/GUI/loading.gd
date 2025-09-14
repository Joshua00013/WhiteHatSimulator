extends Control

var path := "res://Scenes/main.tscn"
var progress := []
var scene_load_status := 0

@onready var label = $Label


func _ready():
	ResourceLoader.load_threaded_request(path)

func _process(delta):
	scene_load_status = ResourceLoader.load_threaded_get_status(path, progress)
	
	label.text = str(floor(progress[0]*100)) + "%"
	
	if scene_load_status == ResourceLoader.THREAD_LOAD_LOADED:
		var new_scene = ResourceLoader.load_threaded_get(path)
		get_tree().change_scene_to_packed(new_scene)
