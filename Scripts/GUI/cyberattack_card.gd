extends NinePatchRect

@export var unlock_override : bool = false
@export_enum("Day 1:1", "Day 2:2", "Day 3:3", "Day 4:4", "Day 5:5") var unlocked_day: int = 1
@export var button : Button

@onready var label: Label = $MarginContainer/VBoxContainer/Label
@onready var locked_message: Label = $MarginContainer/VBoxContainer/LockedMessage
@onready var shine: ColorRect = $Shine

var new := false
func _ready():
	if DayAndNightManager.current_days < unlocked_day && unlock_override == false:
		lock_card()
	
	if DayAndNightManager.current_days == 2 && unlocked_day == 2:
		new = true
		locked_message.text = "Unlock by being on day 2 while holding a flashdrive"
		lock_card()
		GameManager.laptop_flashdrive_inserted.connect(unlock_card)
	if DayAndNightManager.current_days == 3 && unlocked_day == 3:
		new = true
	if DayAndNightManager.current_days >= 4 && unlocked_day == 4 :
		if DayAndNightManager.current_days == 4:
			new = true
		locked_message.text = "Unlock by being on day 4 after seeing the website"
		lock_card()
		if CyberattackManager.website_seen == true:
			unlock_card()
	if DayAndNightManager.current_days == 5 && unlocked_day == 5:
		new = true
		locked_message.text = "Unlock by being on day 5 after seeing the data server"
		lock_card()
		if CyberattackManager.data_server_seen == true:
			unlock_card()
			
	if new == true:
		shine.show()

func lock_card():
	locked_message.show()
	label.hide()
	modulate = Color(0.3, 0.3, 0.3, 1)
	button.disabled = true

func unlock_card():
	locked_message.hide()
	label.show()
	modulate = Color(1.0, 1.0, 1.0, 1.0)
	button.disabled = false
