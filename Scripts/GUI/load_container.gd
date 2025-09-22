# MainMenuSaves.gd
extends PanelContainer

@onready var saves = $VBoxContainer/Saves/VBoxContainer
var save_folder := "user://saves/"
var save_slot_scene = preload("res://GUI/MainMenuUI/save_slot.tscn")

func _ready():
	refresh_saves()

func refresh_saves():
	# Clear old slots
	for slot in saves.get_children():
		slot.queue_free()
	
	var dir = DirAccess.open(save_folder)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if not dir.current_is_dir() and file_name.ends_with(".save"):
				var file = FileAccess.open(save_folder + file_name, FileAccess.READ)
				if file:
					var data: Dictionary = file.get_var() # assumes saved as dict
					file.close()
					
					var player_name: String = data["player_name"]
					var day: int = data.get("initial_day")
					# Instance the slot
					var slot_instance = save_slot_scene.instantiate()
					slot_instance.set_save_info(player_name, day)
					
					# Connect the slot signal to load the save
					slot_instance.connect("save_selected", _on_slot_pressed)
					
					saves.add_child(slot_instance)
			file_name = dir.get_next()
		dir.list_dir_end()

func _on_slot_pressed(player_name: String):
	# Change SaveManager's file name and load
	SaveManager.change_file_name(player_name)
	SaveManager.load_data()
	get_tree().change_scene_to_file("res://Scenes/GUI/loading_save.tscn")
	
func _on_back_pressed():
	hide()
