extends Node3D

# Used for checking if the mouse is inside the Area3D.
var is_mouse_inside = false
# The last processed input touch/mouse event. To calculate relative movement.
var last_event_pos2D = null
# The time of the last event in seconds since engine start.
var last_event_time: float = -1.0

@export var npc_resource : NpcData
@export var password := ""
@export var username := ""
@export var resource_override_password :bool = false

@export var login_screen : Control
@export var flashdrive_item : InvItem
@export var minigame : Node3D
@export var tab : TabContainer
@export var node_viewport : SubViewport
@export var node_quad : MeshInstance3D
@export var node_area : Area3D
@export var camera : Camera3D
@export var interactable : Interactable
@export var deployment_buttons : Control

@onready var return_button = $ReturnButton
@onready var npc_browser = $Model/SubViewport/TabContainer/Desktop/Windows/NPCBrowser
@onready var notepad_text = %NotepadText


var logged_in : bool = false
var weak_passwords = ["", "12345678"]
var strong_password : String = "kdkfiiiJJ34"
var default_prompt_message : String
var active := false
var in_use : bool = false : 
	set(value):
		in_use = value
		if value == false:
			interactable.prompt_message = default_prompt_message
		else:
			interactable.prompt_message = "In use"
var flashdrive_plugged := false

func _ready():
	node_area.mouse_entered.connect(_mouse_entered_area)
	node_area.mouse_exited.connect(_mouse_exited_area)
	node_area.input_event.connect(_mouse_input_event)
	
	default_prompt_message = interactable.prompt_message
	
	if npc_resource != null:
		notepad_text.text = npc_resource.text
		login_screen.username = npc_resource.username
		login_screen.password = npc_resource.password
		npc_browser.change_email(npc_resource.email)
		login_screen.password = strong_password
	else: # Fallback if the resource is left empty
		login_screen.username = username
		login_screen.password = password

# IF NPCS USE WEAK PASSWORDS OR NO PASSWORDS, RANDOMIZE BETWEEN THESE
	if  CyberattackAdaptationManager.no_password_used == true:
		login_screen.password = weak_passwords.pick_random()
	if CyberattackAdaptationManager.weak_passwords == true && CyberattackAdaptationManager.no_password_used == false: # Weak passwords are simply checks for bruteforce
		login_screen.password = strong_password
	
	# IF NPCS SHARE PASSWORDS, AND OVERRIDE IS ON, KEEP THE DEFAULT
	if CyberattackAdaptationManager.sharing_passwords_used == false && resource_override_password == true:
		if npc_resource != null:
			login_screen.password = npc_resource.password
		#else: # RANDOMIZE AS USUAL IF THEY DONT SHARE
			#if CyberattackAdaptationManager.no_password_used == true:
				#login_screen.password = weak_passwords.pick_random()
			#if CyberattackAdaptationManager.weak_passwords == false:
				#login_screen.password = strong_password
			
func _mouse_entered_area():
	is_mouse_inside = true

func _mouse_exited_area():
	is_mouse_inside = false

func _process(_delta):
	if Input.is_action_just_pressed("exit_ui") && active == true:
		exit_ui()

func _unhandled_input(event):
	#Check if the event is esc
	if event is InputEventKey && event.keycode == KEY_ESCAPE:
		return
	# Check if the event is a non-mouse/non-touch event
	for mouse_event in [InputEventMouseButton, InputEventMouseMotion, InputEventScreenDrag, InputEventScreenTouch]:
		if is_instance_of(event, mouse_event):
			# If the event is a mouse/touch event, then we can ignore it here, because it will be
			# handled via Physics Picking.
			return
	node_viewport.push_input(event)

func _mouse_input_event(_camera: Camera3D, event: InputEvent, event_position: Vector3, _normal: Vector3, _shape_idx: int):
	# Get mesh size to detect edges and make conversions. This code only support PlaneMesh and QuadMesh.
	var quad_mesh_size = node_quad.mesh.size

	# Event position in Area3D in world coordinate space.
	var event_pos3D = event_position

	# Current time in seconds since engine start.
	var now: float = Time.get_ticks_msec() / 1000.0

	# Convert position to a coordinate space relative to the Area3D node.
	# NOTE: affine_inverse accounts for the Area3D node's scale, rotation, and position in the scene!
	event_pos3D = node_quad.global_transform.affine_inverse() * event_pos3D

	var event_pos2D: Vector2 = Vector2()

	if is_mouse_inside:
		# Convert the relative event position from 3D to 2D.
		event_pos2D = Vector2(event_pos3D.x, -event_pos3D.y)

		# Right now the event position's range is the following: (-quad_size/2) -> (quad_size/2)
		# We need to convert it into the following range: -0.5 -> 0.5
		event_pos2D.x = event_pos2D.x / quad_mesh_size.x
		event_pos2D.y = event_pos2D.y / quad_mesh_size.y
		# Then we need to convert it into the following range: 0 -> 1
		event_pos2D.x += 0.5
		event_pos2D.y += 0.5

		# Finally, we convert the position to the following range: 0 -> viewport.size
		event_pos2D.x *= node_viewport.size.x
		event_pos2D.y *= node_viewport.size.y
		# We need to do these conversions so the event's position is in the viewport's coordinate system.

	elif last_event_pos2D != null:
		# Fall back to the last known event position.
		event_pos2D = last_event_pos2D

	# Set the event's position and global position.
	event.position = event_pos2D
	if event is InputEventMouse:
		event.global_position = event_pos2D

	# Calculate the relative event distance.
	if event is InputEventMouseMotion or event is InputEventScreenDrag:
		# If there is not a stored previous position, then we'll assume there is no relative motion.
		if last_event_pos2D == null:
			event.relative = Vector2(0, 0)
		# If there is a stored previous position, then we'll calculate the relative position by subtracting
		# the previous position from the new position. This will give us the distance the event traveled from prev_pos.
		else:
			event.relative = event_pos2D - last_event_pos2D
			event.velocity = event.relative / (now - last_event_time)

	# Update last_event_pos2D with the position we just calculated.
	last_event_pos2D = event_pos2D

	# Update last_event_time to current time.
	last_event_time = now
	
	# Finally, send the processed input event to the viewport.
	node_viewport.push_input(event)

func _on_interactable_interact_triggered():
	if in_use:
		return
	#if CyberattackAdaptationManager.weak_passwords == true && login_screen.password == "12345678": # Start using strong passwords if the password is in the weak pool
		#CyberattackAdaptationManager.weak_passwords = false 
	#if CyberattackAdaptationManager.no_password_used == true && login_screen.password == "":
		#CyberattackAdaptationManager.no_password_used = false
		#CyberattackAdaptationManager.weak_passwords = false
	if CyberattackManager.weaponization_finished:
		deployment_buttons.show()
	if camera.is_current() == false && GameManager.remove_item(flashdrive_item) == true:
		minigame.start_minigame()
	if camera.is_current() == false:
		GameManager.player.exit_tool_tip.visible = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		camera.current = true
		GameManager.ui_active = true
		return_button.show()
		active = true
	CyberattackManager.delivery_finished = true
	if logged_in:
		CyberattackAdaptationManager.unattended_pc_used = true

func exit_ui():
	if flashdrive_plugged == true:
		flashdrive_plugged = false
		GameManager.add_item(flashdrive_item)
		minigame.remove_flashdrive()
	return_button.hide()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	GameManager.player.exit_tool_tip.visible = false
	active = false
	GameManager.player_camera.current = true
	GameManager.ui_active = false
	


func _on_control_login_successful() -> void:
	login()

func login():
	tab.current_tab = 1
	logged_in = true
	
func logout():
	tab.current_tab = 0
	logged_in = false

func _on_return_button_pressed():
	Input.action_press("exit_ui")
	Input.action_release("exit_ui")


func _on_flashdrive_minigame_flashdrive_plugged():
	flashdrive_plugged = true
