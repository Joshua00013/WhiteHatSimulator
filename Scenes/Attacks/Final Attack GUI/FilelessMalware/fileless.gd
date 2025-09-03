extends TabContainer

@onready var desktop: MarginContainer = $Margin
@onready var fileless: MarginContainer = $Fileless
@onready var boilerplate: MarginContainer = $boilerplate


func _ready() -> void:
	desktop.visible = true
	fileless.visible = false
	boilerplate.visible = false
func _on_button_pressed() -> void:
	desktop.visible = false
	fileless.visible = true
	boilerplate.visible = false
	
func _on_button_pressed_vscode() -> void:
	boilerplate.visible = true
	desktop.visible = false
	fileless.visible = false
