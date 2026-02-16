extends Sprite3D

@export var day_visible : int
# Called when the node enters the scene tree for the first time.
func _ready():
	if day_visible == DayAndNightManager.initial_day:
		show()
	else:
		hide()
