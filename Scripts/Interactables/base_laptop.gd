extends Node3D

# Used for checking if the mouse is inside the Area3D.
var is_mouse_inside = false
# The last processed input touch/mouse event. To calculate relative movement.
var last_event_pos2D = null
# The time of the last event in seconds since engine start.
var last_event_time: float = -1.0

var active := false
var flash_drive_inserted := false

@export var username: String
@export var password : String
@export var tab : TabContainer
@export var login_screen : Control
@export var laptop_inv_item : InvItem
@export var flashdrive_item : InvItem
@export var minigame : Node3D
@export var success_animation : AnimationPlayer

@onready var node_viewport = $SubViewport
@onready var node_quad = $laptop_base/laptop_screen/Screen
@onready var camera = $Camera3D
@onready var node_area = $laptop_base/laptop_screen/Screen/Area3D
@onready var animation_player = $AnimationPlayer
@onready var return_button = $ReturnButton
@onready var next_button: Button = $Next
@onready var back_button: Button = $Back


signal closed

func _ready():
	UiManager.connect("laptop_play_fileless", _play_fileless_success)
	UiManager.connect("laptop_play_ransomware", _play_ransomware_success)
	UiManager.connect("laptop_play_phishing", _play_phishing_success)
	
	if OS.get_name() == "Android":
		camera.position.z = -0.12
	UiManager.hide_nav_buttons.connect(toggle_controller_buttons.bind(false))
	UiManager.show_nav_buttons.connect(toggle_controller_buttons.bind(true))
	animation_player.play("open_laptop")
	
	#login_screen.password = password
	#login_screen.username = username
	
	node_area.mouse_entered.connect(_mouse_entered_area)
	node_area.mouse_exited.connect(_mouse_exited_area)
	node_area.input_event.connect(_mouse_input_event)

func _mouse_entered_area():
	is_mouse_inside = true

func _mouse_exited_area():
	is_mouse_inside = false

func _process(_delta):
	if Input.is_action_just_pressed("exit_ui") && active == true:
		exit_ui()

func _unhandled_input(event):
	if not active:
		return
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
	if camera.is_current() == false && GameManager.remove_item(flashdrive_item) == true:
		minigame.minigame_start()
	elif camera.is_current() == false:
		display_laptop_ui()
		#GameManager.player.exit_tool_tip.visible = true
		#Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		#camera.current = true
		#GameManager.ui_active = true
		#active = true
		#next_button.show()
	# READ THE COMMENT
	# READ: SHOW RETURN BUTTON REGARDLESS IF MINIGAME IS TRIGGERED OR NOT 
	return_button.show()
	
func exit_ui():
	toggle_controller_buttons(false)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	GameManager.player.exit_tool_tip.visible = false
	active = false
	GameManager.player_camera.current = true
	animation_player.play("close_laptop")
	GameManager.add_item(laptop_inv_item)
	if flash_drive_inserted:
		GameManager.add_item(flashdrive_item)
	
#func _on_login_login_successful():
	#tab.current_tab = 1
	
func free_laptop():
	GameManager.ui_active = false
	closed.emit()
	call_deferred("queue_free")

func display_laptop_ui():
	GameManager.player.exit_tool_tip.visible = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	camera.current = true
	GameManager.ui_active = true
	active = true

func toggle_controller_buttons(visibility : bool):
	if visibility == true:
		next_button.show()
		back_button.show()
	elif visibility == false:
		next_button.hide()
		back_button.hide()


func _on_laptop_minigame_component_minigame_finished() -> void:
	GameManager.laptop_flashdrive_plugged = true
	flash_drive_inserted = true
	display_laptop_ui()
	#active = true
	#camera.current = true

func _play_fileless_success():
	if not CyberattackAdaptationManager.email_used:
		CyberattackAdaptationManager.email_used = true
		
		success_animation.play("open_fileless_email")
		await success_animation.animation_finished
		CyberattackManager.exploitation_finished = true
		
		success_animation.play("download_fileless")
		await success_animation.animation_finished
		CyberattackManager.installation_finished = true
		
		success_animation.play("play_fileless")
		await success_animation.animation_finished
		CyberattackManager.command_and_control_finished = true
		GameManager.stage_finished = true
	elif CyberattackAdaptationManager.email_used:
		success_animation.play("open_fileless_email_fail")
		await success_animation.animation_finished
		UiManager.popup.display_popup("Email failed","The target did not click the attachment")
		
func _play_ransomware_success():
	if not CyberattackAdaptationManager.email_used:
		CyberattackAdaptationManager.email_used = true
		
		success_animation.play("open_ransomware_email")
		await success_animation.animation_finished
		CyberattackManager.exploitation_finished = true
		
		success_animation.play("download_ransomware")
		await success_animation.animation_finished
		CyberattackManager.installation_finished = true
		
		success_animation.play("play_ransomware")
		await success_animation.animation_finished
		CyberattackManager.command_and_control_finished = true
		GameManager.stage_finished = true
	elif CyberattackAdaptationManager.email_used:
		success_animation.play("open_ransomware_email_fail")
		await success_animation.animation_finished
		UiManager.popup.display_popup("Email failed","The target did not click the attachment")
	
func _play_phishing_success():
	if not CyberattackAdaptationManager.email_used:
		CyberattackAdaptationManager.email_used = true
		
		success_animation.play("open_phishing_email")
		await success_animation.animation_finished
		CyberattackManager.exploitation_finished = true
		
		success_animation.play("download_phishing")
		await success_animation.animation_finished
		CyberattackManager.installation_finished = true
		
		success_animation.play("play_phishing")
		await success_animation.animation_finished
		CyberattackManager.command_and_control_finished = true
		GameManager.stage_finished = true
	elif CyberattackAdaptationManager.email_used:
		success_animation.play("open_phishing_email_fail")
		await success_animation.animation_finished
		UiManager.popup.display_popup("Email failed","The target did not click the link")
	
