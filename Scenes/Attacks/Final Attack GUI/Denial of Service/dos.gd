extends TabContainer

@export var animation:AnimationPlayer

var step: int = 0

func _ready() -> void:
	animation.play("start_ddos")
	
func _on_loic_button_down() -> void:
	animation.play("loic")
	
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
		#Stsrt or MSFVENOM Start
		1:
			animation.play("loic_2")
		2: 
			animation.play("loic_3")
		3:
			animation.play("loic_4")
		4:
			animation.play("loic_5")
		5:
			animation.play("loic_6")
		6:
			animation.play("loic_7")
		7:
			animation.play("loic_8")
		8:
			animation.play("loic_9")
		9:
			animation.play("loic_10")
		10:
			animation.play("loic_11")
		11:
			animation.play("loic_12")
		12:
			animation.play("loic_13")
		13:
			animation.play("loic_14")
		14:
			animation.play("ddos_result")



func _on_button_button_down() -> void:
	pass # Replace with function body.
