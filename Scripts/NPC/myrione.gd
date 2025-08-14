extends CharacterBody3D

enum {IDLE, RUN, SIT}
var cur_anim = IDLE

var speed = 3
var run_val = 0
var sit_val = 0

@export var blend_speed = 15

@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animation_tree: AnimationTree = $AnimationTree

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

func _on_debug_timer_timeout() -> void:
	var random_position := Vector3.ZERO
	random_position.z = randf_range(-5.0, -5.0)
	random_position.x = randf_range(-5.0, -5.0)
	navigation_agent_3d.set_target_position(GameManager.player.global_position)
	
func _physics_process(delta: float) -> void:
	handle_animation(delta)
	update_tree()
	var destination = navigation_agent_3d.get_next_path_position()
	var local_destination = destination - global_position
	var direction = local_destination.normalized()
	var rotation_dir = global_position.direction_to(destination)
	velocity = rotation_dir * speed
	
	#Handle animations
	var stop_threshold := 0.0
	if local_destination.length() <= stop_threshold or navigation_agent_3d.is_navigation_finished():
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
	
	move_and_slide()
