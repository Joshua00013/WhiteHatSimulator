extends Label3D

@export var interactable : Area3D

@onready var timer: Timer = $Timer

func _ready() -> void:
	interactable.connect("interact_triggered", handle_dialogue)
	timer.connect("timeout",clear_text)
	
func handle_dialogue():
	text = "What do you want?"
	timer.start()
	
func clear_text():
	text = ""
