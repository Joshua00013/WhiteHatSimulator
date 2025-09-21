extends MarginContainer

@onready var anim_player = $AnimationPlayer

var animations: PackedStringArray = []
var current_index := 0

signal code_finished

func _ready():
	animations = anim_player.get_animation_list()
	if animations.size() > 0:
		anim_player.play(animations[current_index])

func _process(_delta):
	if not visible or animations.is_empty():
		return

	if Input.is_action_just_pressed("next_pressed"):
		if animations[current_index] == "loic_installation_1":
			return
		elif animations[current_index] == "loic_installation_3":
			CyberattackManager.dos_ready = true
			SignalBus.ddos_part1_finished.emit()
			CyberattackManager.weaponization_finished = true
			_play_next()
		else:
			_play_next()

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
	if index == 0:
		_play_next()


func _on_install_pressed() -> void:
	print("nigga")
	_play_next()

func _on_close_pressed() -> void:
	CyberattackManager.dos_ready = true
	SignalBus.ddos_part1_finished.emit()
	emit_signal("code_finished")

#func _weaponization():
	#UiManager.popup.display_popup("Good Job!", "Weaponization is now finished. Now deploy your cyberattack", false)
	#CyberattackManager.weaponization_finished = true
