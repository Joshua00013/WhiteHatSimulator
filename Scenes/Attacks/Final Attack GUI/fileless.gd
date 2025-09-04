extends TabContainer

@onready var desktop: MarginContainer = $Margin
@onready var fileless: MarginContainer = $Fileless


func _ready() -> void:
	desktop.visible = true
	fileless.visible = false
func _on_button_pressed() -> void:
	desktop.visible = false
	fileless.visible = true
	
func _on_button_pressed_vscode() -> void:
	desktop.visible = false
	fileless.visible = false
