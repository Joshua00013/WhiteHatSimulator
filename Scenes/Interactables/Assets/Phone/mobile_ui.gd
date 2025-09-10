extends Control

var timeInSec: int
var toMin
var startHour: int = 8
var day: int 

func _ready() -> void:
	$Timer.start()
	
func _on_timer_timeout() -> void:
	timeInSec +=1
	toMin = timeInSec / 7
	if toMin == 60:
		timeInSec = 0	
		startHour += 1
		
	elif startHour >= 13:
		startHour = startHour - 12
		$Time_Label.text = '%02d:%02d' % [startHour, toMin]

	elif startHour == 5:
		$Timer.stop()
		get_tree().change_scene_to_file("")
		day += 1
		timeInSec =0
		toMin = 0
		startHour = 8	
		print("Day is done")#Tester Only
		
	$Time_Label.text = '%02d:%02d' % [startHour, toMin]
	$Day_Label.text = 'Day %02d'% [day + 1]
