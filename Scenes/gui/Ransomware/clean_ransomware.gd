extends TabContainer

@export var malware_icon := VBoxContainer
@export var decr_icon := VBoxContainer
@export var key_icon := VBoxContainer
@export var decrypted_message := Label
@export var radial_circle_cyberattack_label : Label

func _on_window_container_ransomware_start() -> void:
	current_tab = 1





func _on_button_button_down() -> void:
	current_tab = 3



func _on_password_check_component_correct_password() -> void:
	current_tab = 0
	malware_icon.visible = true
	decr_icon.visible = true
	key_icon.visible = true
	decrypted_message.visible = true
	radial_circle_cyberattack_label.visible = false


func _ransomware_button_down() -> void:
	current_tab = 1


func _bruteforce_button_down() -> void:
	get_tree().change_scene_to_file("res://Scenes/gui/Bruteforce.tscn")


func _fileless_button_down() -> void:
	get_tree().change_scene_to_file("res://Scenes/Attacks/Final Attack GUI/FilelessMalware/Fileless.tscn")


func _phishing_button_down() -> void:
	get_tree().change_scene_to_file("res://Scenes/Attacks/Final Attack GUI/Phishing/PhishingAttack.tscn")


func _dos_button_down() -> void:
	get_tree().change_scene_to_file("res://Scenes/Attacks/Final Attack GUI/Denial of Service/dos.tscn")


func _finish_button_pressed() -> void:
	current_tab= 2
