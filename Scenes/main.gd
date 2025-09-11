extends Node3D

@export var corridor_door : Node3D

func _ready() -> void:
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
	Dialogic.signal_event.connect(_on_dialogic_signal)

func _on_dialogic_signal(argument: String):
	match argument:
		"corridor_unlocked":
			corridor_door.unlock()
			corridor_door.interactable.trigger()
			corridor_door.player_unlocked = true
