extends Control

@onready var time_label: Label = $Time_Label
@onready var day_label: Label = $Day_Label

#@export var normal_speed: int = 5
#@export var fast_speed: int = 100
#@export var cheetah_speed: int = 200

func _ready() -> void:
	DayAndNightManager.time_tick.connect(on_time_tick)

func on_time_tick(day: int, hour: int, minutes: int) -> void:
	day_label.text = "Day " + str(day)
	time_label.text = "%02d:%02d" % [hour,minutes]
