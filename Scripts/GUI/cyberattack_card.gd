extends NinePatchRect

@export_enum("Day 1:1", "Day 2:2", "Day 3:3", "Day 4:4", "Day 5:5") var unlocked_day: int = 1
@export var button : Button
func _ready():
	if DayAndNightManager.current_days < unlocked_day:
		lock_card()

func lock_card():
	modulate = Color(0.3, 0.3, 0.3, 1)
	button.disabled = true
