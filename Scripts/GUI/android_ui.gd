extends CanvasLayer

func _ready():
	match OS.get_name():
		#"Windows":
			#visible = false
		"Android":
			visible = true
			
func _input(event):
	if event.is_action("inventory") && GameManager.ui_active == true:
		visible = false
	elif event.is_action("inventory") && GameManager.ui_active == false:
		visible = true
