extends PanelContainer

@onready var line_edit = $VBoxContainer/LineEdit
@onready var label = $VBoxContainer/Label

func _ready():
	hide()

func _on_back_pressed():
	hide()

func _on_confirm_pressed():
	if line_edit.text == "":
		label.text = "Name field is empty!"
	else:
		GameManager.player_name = line_edit.text
		SaveManager.change_file_name(GameManager.player_name)
		SaveManager.save_data()
		get_tree().change_scene_to_file("res://Scenes/GUI/loading.tscn")
