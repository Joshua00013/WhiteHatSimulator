extends Control
@onready var ransomware_player: TabContainer = $RansomwarePlayer


#For testing only
func _on_pdf_btn_pressed() -> void:
	print("PDF is pressed")

#For testing only
func _on_text_1_btn_pressed() -> void:
	print("text1 is pressed")
	
#func _ready() -> void:	
#	ransomware_player.current_tab += 1
	





func _on_ransomeware_1_pressed() -> void:
	#get_tree().change_scene_to_file("res://Scenes/gui/Ransomware/ransomwareEncrypt_Part2.tscn")
	ransomware_player.current_tab += 1

func _on_ransomware_2_back_pressed() -> void:
	#get_tree().change_scene_to_file("res://Scenes/gui/Ransomware/ransomwareEncrypt_Part1.tscn")
	ransomware_player.current_tab -= 1


func _on_ransomeware_2_next_pressed() -> void:
	#get_tree().change_scene_to_file("res://Scenes/gui/Ransomware/ransomwareEncrypt_Part3.tscn")
	ransomware_player.current_tab += 1
