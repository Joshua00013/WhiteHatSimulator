extends MarginContainer

@export var animation:AnimationPlayer

var step: int = 0

signal change_to_result
func _ready() -> void:
	animation.play("start_of_ddos")
	
func _on_back_button_down() -> void:
	# TODO: Set limits on back and next
	if step >= 1:
		step -= 1
		set_step(step)
		
func _on_next_button_down() -> void:
	step += 1
	set_step(step)

func set_step(step: int) -> void:
	match step:
		# Start or MSFVENOM Start
		1:
			animation.play("ddos_1")
		2: 
			animation.play("ddos_2")
		3:
			animation.play("ddos_3")
		4:
			animation.play("ddos_4")
		5:
			animation.play("ddos_5")
		6:
			animation.play("ddos_6")
		7:
			animation.play("ddos_7")
		8:
			animation.play("ddos_8")
		9:
			animation.play("ddos_9")
		10:
			animation.play("ddos_10")
		11:
			animation.play("ddos_11")
		12:
			animation.play("ddos_12")
		13:
			animation.play("ddos_13")
		14:
			emit_signal("change_to_result")
