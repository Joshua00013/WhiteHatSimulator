extends Control

class_name PopupWindow

@export var heading : Label
@export var body : Label

func _ready():
	UiManager.popup = self
	hide()

func display_popup(new_heading : String, new_body: String):
	heading.text = new_heading
	body.text = new_body
	
	show()

func _on_button_pressed():
	hide()
