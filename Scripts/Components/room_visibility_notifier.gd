extends VisibleOnScreenNotifier3D

@export var room : Node3D

func _ready():
	connect("screen_entered", room.show)
	connect("screen_exited",room.hide)
