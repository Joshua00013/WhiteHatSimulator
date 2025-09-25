extends MarginContainer

@export var animation:AnimationPlayer
@onready var shellcode: VBoxContainer = $Desktop/shellcode

var payload_step: int = 0
var finished

func _ready() -> void:
	terminal_disable()
	animation.play("start_of_fileless_desktop")

func _on_terminal_1_pressed() -> void:
	payload_step += 1
	set_payload_step(payload_step)
		
func _on_ide_pressed() -> void:
	_payload_finished()
	payload_step += 1
	set_payload_step(payload_step)

func _on_exit_button_pressed() -> void:
	if payload_step == 20 or payload_step == 28 and finished == true:
		animation.play("finished")
	else:
		animation.play("exit_not_finished")
		terminal_enable()
		
func _process(_delta: float) -> void:
	if visible && finished == true:
		if Input.is_action_just_pressed("next_pressed") && payload_step != 20 && payload_step != 21: 
			payload_step += 1
			set_payload_step(payload_step)

		elif Input.is_action_just_pressed("back_pressed") && payload_step != 1 && payload_step != 21 && payload_step != 0:
			payload_step -= 1
			set_payload_step(payload_step)
				
func set_payload_step(payload_step: int) -> void:
	match payload_step:
		# WSL Installation
		1:
			animation.play("wsl_installation_1")
		2:
			animation.play("wsl_installation_2")
		3:
			animation.play("wsl_installation_3")
		4:
			animation.play("wsl_installation_4")
		5:
			animation.play("wsl_installation_5")
		6:
			animation.play("wsl_installation_6")
		7:
			animation.play("wsl_installation_7")
		8:
			animation.play("wsl_installation_8")
		9:
			animation.play("wsl_installation_9")
		10:
			animation.play("wsl_installation_10")
		11:
			animation.play("wsl_installation_11")
		12:
			animation.play("wsl_installation_12")
		13:
			animation.play("fileless_payload_1")
		14:
			animation.play("fileless_payload_2")
		15:
			animation.play("fileless_payload_3")
		16:
			animation.play("fileless_payload_4")
		17:
			animation.play("fileless_payload_5")
		18:
			animation.play("fileless_payload_6")
		19:
			animation.play("fileless_payload_7")
		20:
			animation.play("fileless_payload_8")
		21:
			animation.play("cpp_to_exe")
		22:
			animation.play("cpp_to_exe_2")
		23:
			animation.play("cpp_to_exe_3")
		24:
			animation.play("cpp_to_exe_4")
		25:
			animation.play("cpp_to_exe_5")
		26:
			animation.play("cpp_to_exe_6")
		27:
			animation.play("cpp_to_exe_7")
		28:
			animation.play("cpp_to_exe_8")
			
func terminal_disable():
	finished = false
	
func terminal_enable():
	finished = true

func _payload_finished():
	SignalBus.fileless_part2_finished.emit()
