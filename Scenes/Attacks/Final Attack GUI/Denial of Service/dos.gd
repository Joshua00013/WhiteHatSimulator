extends TabContainer

@onready var margin: MarginContainer = $Margin
@onready var ddos_application: MarginContainer = $ddos_application
@onready var ddos_result: MarginContainer = $DDOS_Result

func _ready() -> void:
	margin.visible = true
	ddos_application.visible = false
	ddos_result.visible = false
	
func _on_button_pressed_application() -> void:
	margin.visible = false
	ddos_application.visible = true
	ddos_result.visible = false


func _on_button_button_down() -> void:
	pass # Replace with function body.
