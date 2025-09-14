extends CanvasLayer

func _ready():
	GameManager.connect("ui_updated",toggle)
	GameManager.android_ui = self
	match OS.get_name():
		"Windows":
			visible = false
		"Android":
			visible = true

func toggle(value):
	if OS.get_name() == "Android":
		visible = not value
