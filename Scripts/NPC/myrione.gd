extends CharacterBody3D

enum {IDLE, RUN, SIT}
var cur_anim = IDLE
var sitting := false

var target_area

var speed = 3
var run_val = 0
var sit_val = 0

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

@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animation_tree: AnimationTree = $AnimationTree

func _ready() -> void:
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
		var target_area = schedule[8]
		navigation_agent_3d.set_target_position(target_area.global_position)
	DayAndNightManager.time_tick.connect(calc_schedule)

func calc_schedule(day: int, hour: int, minutes: int):
	change_target(schedule[hour])

func change_target(new_target):
	if new_target == null:
		return
		
	sitting = false
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

func update_tree():
	animation_tree["parameters/Run/blend_amount"] = run_val
	animation_tree["parameters/Sit/blend_amount"] = sit_val

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
	if sitting:
		velocity = Vector3.ZERO
		cur_anim = SIT
		move_and_slide()
		return
	elif local_destination.length() <= stop_threshold or navigation_agent_3d.is_navigation_finished():
		velocity = Vector3.ZERO
		cur_anim = IDLE
	elif direction:
		cur_anim = RUN
	else:
		cur_anim = IDLE
	
	#Rotation
	var ROTATION_SPEED = 1
	var target_rotation := rotation_dir.signed_angle_to(Vector3.MODEL_FRONT, Vector3.DOWN)
	if abs (target_rotation - rotation.y) > deg_to_rad(100):
		ROTATION_SPEED = 20 #Rotate faster if more than 60 degrees needed
	rotation.y = move_toward(rotation.y, target_rotation, delta * ROTATION_SPEED)
	
	


func _on_navigation_agent_3d_navigation_finished() -> void:
	if target_area.has_node("Chair"):
		sit()


func _on_navigation_agent_3d_velocity_computed(safe_velocity: Vector3) -> void:
	velocity = velocity.move_toward(safe_velocity, .25)
	move_and_slide()
