extends Node3D

func _ready() -> void:
	DayAndNightManager.time_tick.connect(calc_schedule)
	
func calc_schedule(day: int, hour: int, minutes: int):
	match hour:
		8:
			pass
		9:
			pass
