extends CanvasLayer

func _ready():
	match OS.get_name():
		"Windows":
			visible = false
		"Android":
			visible = true
