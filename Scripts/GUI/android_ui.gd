extends CanvasLayer

func _ready():
	GameManager.android_ui = self
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
