extends RayCast3D

@onready var prompt = $Prompt
var can_interact := true
func _physics_process(delta):
	prompt.text = ""
	
	if is_colliding():
		var collider = get_collider()
		prompt.text = "Interact" + collider.name
