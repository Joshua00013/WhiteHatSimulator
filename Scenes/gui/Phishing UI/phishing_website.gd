extends MarginContainer

@export var animation: AnimationPlayer
@onready var urlbar: TextEdit = $ColorRect/SearchBar/urlbar

var typing 
var search_active = false
var url_link = "https://www.pulseforge-studio.com"
var step: int = 0
var scene = 1

signal change_to_terminal
signal change_to_deployment

func _ready() -> void:
	_play_scene_animation()

func _on_search_icon_pressed() -> void:
	animation.play("phishing_desktop_3")

	
func _on_next_pressed() -> void:
	step += 1
	set_step(step)

func set_step(step: int) -> void:
	match step:
		1:
			emit_signal("change_to_terminal")
			scene += 1
			_play_scene_animation()
		2:
			animation.play("phishing_fake_website")
		3:
			animation.play("phishing_fake_website_2")
		4:
			emit_signal("change_to_deployment")

func _play_scene_animation() -> void:
	if scene == 1:
		animation.play("phishing_desktop_start")
	elif scene == 2:
		step += 1
		set_step(step)


func _on_search_button_pressed() -> void:
	animation.play("typing_site_1")
	typing = 0
	search_active = true
			
func _process(_delta: float) -> void:
	if search_active:
		for key in range(KEY_SPACE, KEY_Z + 1): 
			if Input.is_physical_key_pressed(key):
				typing += 1
				match typing:
					1:
						animation.play("typing_site_2")
					2:
						animation.play("typing_site_3")
					3:
						animation.play("typing_site_4")
					4:
						animation.play("typing_site_5")
					5:
						animation.play("typing_site_6")
					6:
						animation.play("typing_site_7")
					7:
						animation.play("typing_site_8")
					8:
						animation.play("typing_site_9")
					9:
						animation.play("typing_site_10")
					10:
						animation.play("typing_site_11")
					11:
						animation.play("typing_site_12")
					12:
						animation.play("typing_site_13")
					13:
						animation.play("typing_site_14")
					14:
						animation.play("typing_site_15")
					15:
						animation.play("typing_site_16")
					16:
						animation.play("typing_site_17")
					17:
						animation.play("typing_site_18")
					18:
						animation.play("typing_site_19")
					19:
						animation.play("typing_site_20")
					20:
						animation.play("typing_site_21")
					21:
						animation.play("typing_site_22")
					22:
						animation.play("typing_site_23")
					23:
						animation.play("typing_site_24")
					24:
						animation.play("typing_site_25")
					25:
						animation.play("typing_site_26")
					26:
						animation.play("website_search")
