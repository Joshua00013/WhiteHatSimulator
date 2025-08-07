extends Control

@onready var ransomware_player: TabContainer = $RansomwarePlayer

func _on_next_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/gui/Ransomware/ransomwareEncrypt_Part2.tscn")

func _ready() -> void:
	pass
	
	ransomware_player.current_tab += 1
