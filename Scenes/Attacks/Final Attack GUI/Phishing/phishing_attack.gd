extends TabContainer

@export var animation:AnimationPlayer
@onready var urlbar: TextEdit = $website/ColorRect/SearchBar/urlbar

var url_link = "https://www.pulseforge-studio.com"
var step: int = 0

func _ready() -> void:
	animation.play("pishing_start")

func _on_button_pressed_website() -> void:
	animation.play("website_pressed")
	
func _on_button_pressed_vscode() -> void:
	animation.play("vscode")

func _search_pressed() -> void:
	if urlbar.text == url_link:
		animation.play("correct_url")
	else:
		if urlbar.text != url_link:
			animation.play("wrong_url")
			
func _on_next_button_down() -> void:
	step += 1
	set_step(step)

func _on_back_button_down() -> void:
	# TODO: Set limits on back and next
	if step >= 1:
		step -= 1
		set_step(step)
		
func set_step(step: int) -> void:
	match step:
		1:
			animation.play("website_searching_track_1")
		2:
			animation.play("opening_vscode")
		3:
			animation.play("vscode_copying_website_1")
		4:
			animation.play("vscode_copying_website_2")
		5:
			animation.play("vscode_copying_website_3")
		6:
			animation.play("pishing_fake_website")
		7:
			animation.play("pishing_fake_website_2")
		8:
			animation.play("pishing_backend")
		9:
			animation.play("pishing_backend_2")
		10:
			animation.play("pishing_deployment")
		11:
			exit_ui()
			
func exit_ui():
	match OS.get_name():
		"Android":
			GameManager.android_ui.visible = true #Change Android UI visibility to shown
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	GameManager.player.exit_tool_tip.visible = false
	GameManager.player_camera.current = true
	GameManager.ui_active = false
			
			
