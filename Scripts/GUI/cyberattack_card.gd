extends NinePatchRect

@export var unlock_override : bool = false
@export_enum("Day 1:1", "Day 2:2", "Day 3:3", "Day 4:4", "Day 5:5") var unlocked_day: int = 1
@export var button : Button
func _ready():
	if DayAndNightManager.current_days < unlocked_day && unlock_override == false:
		lock_card()
	
	if DayAndNightManager.current_days == 2 && unlocked_day == 2:
		lock_card()
		GameManager.laptop_flashdrive_inserted.connect(unlock_card)
		
	if DayAndNightManager.current_days == 5 && unlocked_day == 5:
		lock_card()
		CyberattackManager.website_seen_changed.connect(unlock_card)

func lock_card():
	modulate = Color(0.3, 0.3, 0.3, 1)
	button.disabled = true

func unlock_card():
	modulate = Color(1.0, 1.0, 1.0, 1.0)
	button.disabled = false
