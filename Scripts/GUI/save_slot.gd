extends PanelContainer

@export var delete_btn : Button
@export var button : Button
@export var label : Label

var player_name : String
signal save_selected

func set_save_info(p_name: String, day: int):
	player_name = p_name
	label.text = "%s (Day %d)" % [player_name, day]

	# Connect the button to emit signal
	if not button.pressed.is_connected(_on_button_pressed):
		button.pressed.connect(_on_button_pressed)

func _on_button_pressed():
	emit_signal("save_selected", player_name)

func _on_delete_pressed():
	var dir = DirAccess.open("user://saves/")
	if dir:
		var err = dir.remove(player_name + ".save")
		if err != OK:
			print("Failed to delete save:", player_name)
	queue_free()  # Remove the slot from the UI
