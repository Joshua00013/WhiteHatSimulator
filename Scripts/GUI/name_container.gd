extends ColorRect

@onready var line_edit = $NamePanel/VBoxContainer/LineEdit
@onready var label = $NamePanel/VBoxContainer/Label

func _on_back_pressed():
	hide()

func _on_confirm_pressed():
	if line_edit.text == "":
		label.text = "Name field is empty!"
	else:
		var file_name = line_edit.text
		var save_path = "user://saves/" + file_name + ".save"

		if FileAccess.file_exists(save_path):
			label.text = "A save with this name already exists!"
		else:
			GameManager.player_name = file_name
			SaveManager.change_file_name(GameManager.player_name)
			SaveManager.save_data()
			get_tree().change_scene_to_file("res://Scenes/GUI/loading.tscn")
