extends Control

class_name TaskBox

@export var task_desc : RichTextLabel
@export var animation_player : AnimationPlayer

var enabled : bool = true

func _ready():
	CyberattackManager.phase_updated.connect(_on_phase_updated)
	UiManager.task_box = self
	GameManager.connect("ui_updated",toggle)
	
	_on_phase_updated(CyberattackManager.current_phase)

func toggle(value):
	pass
	#visible = not value

func _on_phase_updated(phase : String):
	print(phase)
	match phase:
		"reset":
			task_desc.text = "Reconnaisance, find a vulnerability to exploit (Read the file in the inventory for info)"
		"reconnaissance":
			task_desc.text = "Weaponization: go to the cafeteria and program a cyberattack"
		"weaponization":
			task_desc.text = "Delivery: deliver the cyberattack through your chosen method. You may plant flashdrives to PCs or make the website go live"
		"delivery":
			task_desc.text = "Exploitation: execute the program. Be ready to abort if detected."
		"exploitation":
			task_desc.text = "Installation: establish persistence on the target machine. The antivirus should not detect it. If using your own program, run it." #Play animation where the victim installs it, restards the pc and it still persists. 
		"installation":
			task_desc.text = "Command and Control: gain access to the inforation that you are looking for (Read the file in the inventory for info)"
		"command_and_control":
			task_desc.text = "Actions on objectives: You have now achieved your objective. Head out to the door to finish the stage"
		"actions_on_objectives":
			task_desc.text = "Actions on objectives: You have now achieved your objective. Head out to the door to finish the stage"


func _on_button_button_down():
	if enabled == true:
		animation_player.play("hide")
	elif enabled == false:
		animation_player.play_backwards("hide")
	enabled = !enabled
