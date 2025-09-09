extends TabContainer

@onready var icon: VBoxContainer = $Margin/Desktop/Icon
#var icon : PackedScene = preload("res://Scenes/gui/CleanUI/icon.tscn")
@onready var desktop: VFlowContainer = $Margin/Desktop

func _on_button_button_down() -> void:
	icon.queue_free()
	
	#var new_icon = icon.instantiate()
	#desktop.add_child(new_icon)

#Code for handling RADIAL MENU
func _gui_input(event):
		
	if event is InputEventMouseButton:		
		# open the menu
		if event.is_pressed() and event.button_index == MOUSE_BUTTON_RIGHT:
			var m = get_local_mouse_position()
			# Pass the center position to open_menu as a Vector2!
			$Margin/Desktop/RadialMenu.open_menu(m)
			# Make sure we don't handle the click again anywhere else...
			get_viewport().set_input_as_handled()
