extends MarginContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	if OS.get_name() == "Android":
		hide()
		return
	GameManager.ui_updated.connect(toggle)

func toggle(value):
	if value == true:
		hide()
	else:
		show()
