extends CharacterBody3D

class_name NPC

enum {IDLE, RUN, SIT, SPRINT}
enum WorkState {WORK, BREAK, CHASE}
var cur_anim = IDLE
var sitting := false
var talking := false
var idle := false
var target_area
var logged_in := false

var speed = 3
var run_val = 0
var sit_val = 0

@export var dialogue : String
@export var PersonalComputer : Node3D
@export var state = WorkState.WORK
@export var target_area_1 : Node3D
@export var target_area_2 : Node3D
@export var target_area_3 : Node3D
@export var target_area_4 : Node3D
@export var target_area_5 : Node3D
@export var target_area_6 : Node3D
@export var target_area_7 : Node3D
@export var target_area_8 : Node3D
@export var target_area_9 : Node3D
@export var target_area_10 : Node3D

var schedule : Dictionary = {}

@export var blend_speed = 15
@export var collision_shape : CollisionShape3D

@onready var nav_agent_refresh_timer: Timer = $NavAgentRefreshTimer
@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var interactable: Interactable = $Interactable

func _ready() -> void:
	navigation_agent_3d.connect("navigation_finished",_on_navigation_agent_3d_navigation_finished)
	navigation_agent_3d.connect("velocity_computed",_on_navigation_agent_3d_velocity_computed)
	nav_agent_refresh_timer.connect("timeout",refresh_agent)
	interactable.connect("interact_triggered",_on_interactable_interact_triggered)
	
	Dialogic.timeline_ended.connect(_on_timeline_ended)
	DayAndNightManager.time_tick_hour.connect(calc_schedule)
	
	schedule = {
	8: target_area_1,
	9: target_area_2,
	10: target_area_3,
	11: target_area_4,
	12: target_area_5,
	13: target_area_6,
	14: target_area_7,
	15: target_area_8,
	16: target_area_9,
	17: target_area_10,
	}
	if schedule[8]!=null:
		target_area = schedule[8]
		navigation_agent_3d.set_target_position(target_area.global_position)

func calc_schedule(hour: int):
	if schedule.has(hour) and schedule[hour] != null and state != WorkState.CHASE: #Proceed as usual if not chasing a target
		change_target(schedule[hour])
		
		if hour >= 8 and hour <= 10:
			change_state(WorkState.WORK)
		elif hour >= 11 and hour <= 13:
			change_state(WorkState.BREAK)
		elif hour >= 14 and hour <= 17:
			change_state(WorkState.WORK)
	
	print (state)
	if cur_anim == SIT && state == WorkState.WORK && PersonalComputer != null:
		if logged_in == false:
			logged_in = true
			PersonalComputer.login()
	elif state == WorkState.BREAK && PersonalComputer != null:
		if logged_in == true:
			logged_in = false
			PersonalComputer.logout()

func change_target(new_target):
	if new_target == null:
		return
		
	sitting = false
	idle = false
	target_area =  new_target
	navigation_agent_3d.set_target_position(new_target.global_position)

func sit():
	global_position.x = target_area.global_position.x
	global_position.z = target_area.global_position.z
	global_rotation = target_area.global_rotation
	sitting = true

func handle_animation(delta):
	match cur_anim:
		IDLE:
			run_val = lerpf(run_val, 0, blend_speed * delta)
			sit_val = lerpf(sit_val, 0, blend_speed * delta)
		RUN:
			run_val = lerpf(run_val, 0.5, blend_speed * delta)
			sit_val = lerpf(sit_val, 0, blend_speed * delta)
		SIT:
			run_val = lerpf(run_val, 0, blend_speed * delta)
			sit_val = lerpf(sit_val, 1, blend_speed * delta)
		SPRINT:
			run_val = lerpf(run_val, 1, blend_speed * delta)
			sit_val = lerpf(sit_val, 0, blend_speed * delta)

func update_tree():
	animation_tree["parameters/Run/blend_amount"] = run_val
	animation_tree["parameters/Sit/blend_amount"] = sit_val
	animation_tree.set("parameters/Run/playback_speed", run_val)

func randomize_position():
	var random_position := Vector3.ZERO
	random_position.z = randf_range(-5.0, -5.0)
	random_position.x = randf_range(-5.0, -5.0)

func _physics_process(delta: float) -> void:
	
	handle_animation(delta)
	update_tree()
	var destination = navigation_agent_3d.get_next_path_position()
	var local_destination = destination - global_position
	var direction = local_destination.normalized()
	var new_velocity = direction * speed
	navigation_agent_3d.set_velocity(new_velocity)
	
	var rotation_dir = global_position.direction_to(destination)
	#velocity = rotation_dir * speed
	
	#Handle animations
	var stop_threshold := 0.0
	if talking || idle:
		stop_movement()
		cur_anim = IDLE
		return
	elif sitting:
		stop_movement()
		cur_anim = SIT
		return
	elif local_destination.length() <= stop_threshold or navigation_agent_3d.is_navigation_finished():
		velocity = Vector3.ZERO
		cur_anim = IDLE
	elif direction && state == WorkState.CHASE:
		cur_anim = SPRINT
	elif direction:
		cur_anim = RUN
	else:
		cur_anim = IDLE
		# Rotation (yaw only)
	if direction != Vector3.ZERO:
		var target_rotation = atan2(direction.x, direction.z)  # yaw angle in radians
		var ROTATION_SPEED = 5.0  # radians/sec (~286 deg/sec)
		rotation.y = move_toward(rotation.y, target_rotation, ROTATION_SPEED * delta)

func _on_navigation_agent_3d_navigation_finished() -> void:
	if "copy_rotate" in target_area and target_area.copy_rotate:
		global_rotation = target_area.global_rotation
		print("ROTATE")
	if target_area.has_node("Chair"):
		sit()
	else:
		idle = true

func _on_navigation_agent_3d_velocity_computed(safe_velocity: Vector3) -> void:
	if talking or sitting:
		stop_movement()
		return
	velocity = velocity.move_toward(safe_velocity, .25)
	move_and_slide()

func stop_movement():
	velocity = Vector3.ZERO
	move_and_slide()
	return

func change_state(value):
	state = value
	if state == WorkState.CHASE:
		speed *= 2
		change_target(GameManager.player)
		nav_agent_refresh_timer.start()

func refresh_agent():
	change_target(GameManager.player)

func show_dialogoue(dialogue_string):
	talking = true
	if Dialogic.current_timeline != null:
		return
	Dialogic.start(dialogue_string)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	GameManager.ui_active = true

func _on_timeline_ended():
	talking = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	GameManager.ui_active = false

func _on_interactable_interact_triggered() -> void:
	show_dialogoue(dialogue)
	
