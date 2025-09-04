extends Node

const MINUTES_PER_DAY: int = 24 * 60
const 	MINUTES_PER_HOUR: int = 60
const GAME_MINUTES_DURATION:float = TAU / MINUTES_PER_DAY

# Speed ng Time 
var game_speed: float = 2.0

var initial_day: int = 1
var initial_hour: int = 8
var initial_minutes: int = 30

var time: float = 0.0
var current_minutes: int = -1
var current_days: int = 0

signal game_time(time: float)
signal time_tick(day: int, hour: int, minutes: int)
signal time_tick_day(day: int)

func _ready() ->void:
	set_initial_time()
	
func _process(delta: float) -> void:
	time += delta * game_speed * GAME_MINUTES_DURATION
	game_time.emit(time)
	
	recalculate_time()

func set_initial_time() -> void:
	var initial_total_minutes = initial_day * MINUTES_PER_DAY + (initial_hour * MINUTES_PER_HOUR) + initial_minutes
	
	time = initial_total_minutes * GAME_MINUTES_DURATION
	
func recalculate_time() -> void:
	var total_minutes: int = int(time / GAME_MINUTES_DURATION)
	var day: int = int(total_minutes / MINUTES_PER_DAY)
	var current_day_minutes: int = total_minutes % MINUTES_PER_DAY
	var hour: int = int(current_day_minutes / MINUTES_PER_HOUR)
	var minutes: int = int(current_day_minutes % MINUTES_PER_HOUR)
	
	if current_minutes != minutes:
		current_minutes = minutes
		time_tick.emit(day, hour, minutes)
		
	if  current_days != day:
		current_days = day
		time_tick_day.emit(day)
	
