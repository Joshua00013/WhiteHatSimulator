extends Control

var path := "res://Scenes/main.tscn"
var progress: Array = []  # keep as array
var scene_load_status := 0
@onready var label = $Label
@onready var intro: AspectRatioContainer = $Control

var intro_done := false

func _ready():
	ResourceLoader.load_threaded_request(path)
	SignalBus.intro_finished.connect(_on_intro_finished)

func _process(delta):
	scene_load_status = ResourceLoader.load_threaded_get_status(path, progress)

	if progress.size() > 0:
		label.text = str(floor(progress[0] * 100)) + "%"
	else:
		label.text = "0%"

	if scene_load_status == ResourceLoader.THREAD_LOAD_LOADED and intro_done:
		var new_scene = ResourceLoader.load_threaded_get(path)
		SceneTransition.fade_in()
		get_tree().change_scene_to_packed(new_scene)

func _on_intro_finished():
	intro.hide()
	label.show()
	intro_done = true
