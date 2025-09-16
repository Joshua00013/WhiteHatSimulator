extends HBoxContainer

@export var time_label: Label
@export var day_label : Label

#@export var normal_speed: int = 5
#@export var fast_speed: int = 100
#@export var cheetah_speed: int = 200

func _ready() -> void:
	DayAndNightManager.time_tick.connect(on_time_tick)
	GameManager.connect("ui_updated",toggle)

func on_time_tick(day: int, hour: int, minutes: int) -> void:
	day_label.text = "Day " + str(day)
	time_label.text = "%02d:%02d" % [hour,minutes]

func toggle(value):
	visible = not value
