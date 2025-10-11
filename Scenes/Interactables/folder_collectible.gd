extends Node3D

@export var day1_file : InvItem
@export var day2_file : InvItem
@export var day3_file : InvItem
@export var day4_file : InvItem
@export var day5_file : InvItem

var item : InvItem

func _ready():
	if DayAndNightManager.initial_day == 1:
		item = day1_file
	elif DayAndNightManager.initial_day == 2:
		item = day2_file
	elif DayAndNightManager.initial_day == 3:
		item = day3_file
	elif DayAndNightManager.initial_day == 4:
		item = day4_file
	elif DayAndNightManager.initial_day == 5:
		item = day5_file


func _on_interactable_interact_triggered():
	GameManager.add_item(item)
	queue_free()
