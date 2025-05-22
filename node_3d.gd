extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 10
@export var sensitivity := 0.25
@export var min_angle = -80
@export var max_angle = 90
@export var accel = 16
@export var crouch_height = 1.0 #Crouch height for adjusting character size
@export var crouch_transition = 4.0 #Crouch movement smoothing for lerping

@onready var collision_shape = $CollisionShape3D
@onready var head = $Head

var stand_height : float
var look_rotation : Vector2

func _ready():
	stand_height = collision_shape.shape.height #Store the height of the collision shape when the player is standing
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		look_rotation.y -= (event.relative.x * sensitivity) #Subtract horizontal mouse movement (x) from the head's y rotation (horizontal rotation from y pole)
		look_rotation.x -= (event.relative.y * sensitivity)
		look_rotation.x = clamp(look_rotation.x, min_angle, max_angle) #Minimum and maximum rotation of the vertical rotation
		
	elif event.is_action_pressed("interact") && GameManager.ui_active == true || event.is_action_pressed("pause"):
		#Set the cursor visibility to default when a UI is active or game has been paused.
		#Maybe handle game pause/resume and ui active in gamemanager later instead of in the player node.
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	elif Input.is_action_pressed("crouch"):
		GameManager.is_crouching = false
		crouch(delta,GameManager.is_crouching)
	else:
		GameManager.is_crouching = true
		crouch(delta,GameManager.is_crouching)
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("strafe_left", "strafe_right", "move_forward", "move_backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction: #Used lerping for smoother movement
		velocity.x = lerp(velocity.x, direction.x * SPEED, accel * delta)
		velocity.z = lerp(velocity.z, direction.z * SPEED, accel * delta)
	else:
		velocity.x = lerp(velocity.x, 0.0, accel * delta)
		velocity.z = lerp(velocity.z, 0.0, accel * delta)

	move_and_slide()
	
	head.rotation_degrees.x = look_rotation.x # Set the vertical rotation to the head
	rotation_degrees.y = look_rotation.y # Set the horizontal rotation to the whole body
	
func crouch(delta : float, inactive = false):
	var target_height : float = crouch_height if inactive == false else stand_height
	collision_shape.shape.height =lerp(collision_shape.shape.height, target_height, crouch_transition*delta)
	collision_shape.position.y = lerp(collision_shape.position.y,target_height * 0.5,crouch_transition*delta) # Set the position of the collision shape to the half of the target height
	head.position.y = lerp(head.position.y, target_height, crouch_transition * delta) # Set the position of the head
