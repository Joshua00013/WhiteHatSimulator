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







#Next button 
func _on_ransomeware_next_pressed() -> void:
	ransomware_player.current_tab += 1

#Back button
func _on_ransomeware_back_btn_pressed() -> void:
	ransomware_player.current_tab -= 1.

#Pdf icon Button
func _pdf_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/gui/Ransomware/ransomwareEncrypt_Start1.tscn")

#Godot svg Button
func _on_godot_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/gui/Ransomware/ransomwareEncrypt_Start2.tscn")


func _on_companyfile_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/gui/Ransomware/ransomwareEncrypt_Start3.tscn")


func _on_malware_button_pressed() -> void:
	ransomware_player.current_tab += 1.
