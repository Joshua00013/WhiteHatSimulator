extends MarginContainer

@onready var anim_player = $AnimationPlayer
@onready var option_button: OptionButton = $TabContainer/Background/SearchBar/ButtonsContainer/Panel/OptionButton
var animations: PackedStringArray = []
var current_index := 0

func _ready():
	animations = anim_player.get_animation_list()
	if animations.size() > 0:
		anim_player.play(animations[current_index])

func _process(_delta):
	if not visible or animations.is_empty():
		return

	if Input.is_action_just_pressed("next_pressed"):
		if animations[current_index] == "phishing_desktop_1":
			return
		elif animations[current_index] == "phishing_desktop_2":
			SignalBus.phishing_part3_finished.emit()
			_play_next()
		else:
			_play_next()
	# Remove or add the item based on the condition
	elif animations[current_index] == "phishing_desktop_1":
		if CyberattackManager.website_seen == true:
			option_button.visible = true
		elif CyberattackManager.website_seen == false:
			option_button.visible = false
	
		
func _play_next():
	if current_index < animations.size() - 1:
		current_index += 1
		anim_player.play(animations[current_index])
	else:
		if animations[current_index] == "reset":
			emit_signal("code_finished")

func _play_previous():
	if current_index > 0:
		current_index -= 1
		anim_player.play(animations[current_index])

func _on_option_button_item_selected(index: int) -> void:
	if index == 0: _play_next()
	
			
	
