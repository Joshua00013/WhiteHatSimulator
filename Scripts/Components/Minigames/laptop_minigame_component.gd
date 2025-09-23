extends Node3D

@export var flashdrive : Node3D
@export var camera : Camera3D
@export var laptop_camera : Camera3D
@export var flash_drive_item : InvItem

var position_minimum_x = Vector3(-0.941, 0.021, -0.350)
var starting_position = Vector3(-0.941, 0.021, -0.317)
var x_snap_position = Vector3(-0.941, 0.021, 0.036)
var laptop_snap_position = Vector3(-0.709, 0.021, 0.036)

var screen_limit_ratio := 1
var last_mouse_z := 192.0
var last_mouse_x := 192.0
var active := false
var sensitivity = 0.01
var dragging := false 
var initial_cursor_x = 0.0
var initial_flashdrive_x
var initial_flashdrive_z
var move_along_x := false

var snapped_ready : bool = false
var flashdrive_snapped : bool = false
signal minigame_finished
signal minigame_exited

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("exit_ui") && active == true:
		exit_ui()
	if flashdrive != null && flashdrive.position.z > 0.039 && active == true && flashdrive_snapped == false:
		flashdrive.position.z = 0.039
		flashdrive_snapped = true
	if flashdrive != null && flashdrive.position.x > -0.704 && flashdrive_snapped == true && active == true:
		flashdrive.position.x = -0.704
		active = false
		minigame_finished.emit()

func _input(event):
	if Input.is_action_just_pressed("exit_ui") && active == true:
		exit_ui()
		# Handle hold start/end to prevent teleport
	if active:
		if Input.is_action_just_pressed("hold"):
			var mouse_pos = get_viewport().get_mouse_position()
			last_mouse_z = mouse_pos.x
			last_mouse_x = mouse_pos.y
			dragging = true
		elif Input.is_action_just_released("hold"):
			dragging = false
	if Input.is_action_just_released("hold") or (event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and not event.pressed):
		dragging = false
		
	if active == true && flashdrive_snapped == false:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT:
				dragging = event.pressed
				last_mouse_z = event.position.x
		elif event is InputEventMouseMotion and dragging:
			var screen_pos = camera.unproject_position(global_transform.origin)
			var screen_width = get_viewport().get_visible_rect().size.x
			var screen_limit = screen_width * screen_limit_ratio

			if screen_pos.x < screen_limit:
				var delta_z = event.relative.x # Production comment: Replace event with the actual position of the mouse.
				flashdrive.position.z += delta_z * sensitivity *0.2
				
		if Input.is_action_pressed("hold"):
				var mouse_pos = get_viewport().get_mouse_position()
				var screen_pos = camera.unproject_position(global_transform.origin)
				var screen_height = get_viewport().get_visible_rect().size.x
				var screen_limit = screen_height * screen_limit_ratio

				if screen_pos.x < screen_limit:
					var delta_z = mouse_pos.x - last_mouse_z #last_mouse is the starting position of the mouse according to the object
					flashdrive.position.z += delta_z * sensitivity * 0.2
					last_mouse_z = mouse_pos.x
	elif active == true && flashdrive_snapped == true:
		if not snapped_ready:
		# Wait for the first click to enable control
			if (event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed) or Input.is_action_pressed("hold"):
				last_mouse_x = get_viewport().get_mouse_position().y
				snapped_ready = true
		else:
			if event is InputEventMouseButton:
				if event.button_index == MOUSE_BUTTON_LEFT:
					dragging = event.pressed
					last_mouse_x = event.position.y
			elif event is InputEventMouseMotion and dragging:
				var screen_pos = camera.unproject_position(global_transform.origin)
				var screen_width = get_viewport().get_visible_rect().size.y
				var screen_limit = screen_width * screen_limit_ratio

				if screen_pos.y < screen_limit:
					var delta_x = event.relative.y # Production comment: Replace event with the actual position of the mouse.
					flashdrive.position.x -= delta_x * sensitivity *0.2
					
			if Input.is_action_pressed("hold"):
					var mouse_pos = get_viewport().get_mouse_position()
					var screen_pos = camera.unproject_position(global_transform.origin)
					var screen_height = get_viewport().get_visible_rect().size.y
					var screen_limit = screen_height * screen_limit_ratio

					if screen_pos.y < screen_limit:
						var delta_x = mouse_pos.y - last_mouse_x #last_mouse is the starting position of the mouse according to the object
						flashdrive.position.x -= delta_x * sensitivity * 0.2
						last_mouse_x = mouse_pos.y

#func _process(_delta):
	#if Input.is_action_just_pressed("exit_ui") && active == true:
		#GameManager.add_item(flash_drive_item)
		#exit_ui()
	#if Input.is_action_pressed("hold") and active and dragging:
		#var current_mouse_pos = get_viewport().get_mouse_position()
		#var horizontal_movement = current_mouse_pos.x - initial_cursor_x
		#
		#if move_along_x:
			#var new_x = initial_flashdrive_z - horizontal_movement * sensitivity * 0.1
			#flashdrive.position.x = clamp(new_x, x_snap_position.x, laptop_snap_position.x)
			#
			## SUCCESS: flashdrive fully plugged
			#if is_equal_approx(flashdrive.position.x, laptop_snap_position.x):
				#active = false
				#minigame_finished.emit()
		#else:
			#var new_z = initial_flashdrive_x + horizontal_movement * sensitivity * 0.08
			#flashdrive.position.z = clamp(new_z, position_minimum_x.z, x_snap_position.z)
			#if new_z >= x_snap_position.z:
				#move_along_x = true
				#initial_cursor_x = current_mouse_pos.x
				#initial_flashdrive_z = flashdrive.position.x
		#
#func _input(event):
	#if event.is_action_pressed("hold") and active:
		#initial_cursor_x = get_viewport().get_mouse_position().x
		#initial_flashdrive_x = flashdrive.position.z   # starting Z
		#initial_flashdrive_z = flashdrive.position.x   # starting X
		#dragging = true
	#elif event.is_action_released("hold") and active:
		#dragging = false

func initialize_minigame():
	flashdrive.show()
	flashdrive.position = starting_position
	flashdrive_snapped = false
	camera.current = true

func minigame_start() -> void:
	GameManager.ui_active = true
	match OS.get_name():
		"Android":
			GameManager.android_ui.visible = false #Change Android UI visibility to hidden
			
	if camera.is_current() == false:
		initialize_minigame()
		GameManager.player.exit_tool_tip.visible = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		active = true

func exit_ui():
	active = false
	match OS.get_name():
		"Android":
			GameManager.android_ui.visible = true #Change Android UI visibility to shown
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	GameManager.add_item(flash_drive_item)
	GameManager.player_camera.current = true
	GameManager.ui_active = false
