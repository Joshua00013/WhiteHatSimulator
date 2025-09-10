extends VisibleOnScreenNotifier3D

@export var room : Node3D

func _ready():
	screen_entered.connect(_on_screen_entered)
	screen_exited.connect(_on_screen_exited)

func _on_screen_entered():
	room.show()
	room.process_mode = Node.PROCESS_MODE_INHERIT  # resume processing

func _on_screen_exited():
	room.hide()
	room.process_mode = Node.PROCESS_MODE_DISABLED # stop all _process/_physics_process
