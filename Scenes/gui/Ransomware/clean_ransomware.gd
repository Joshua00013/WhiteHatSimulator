extends TabContainer

@onready var desktop_default: MarginContainer = $DesktopDefault
@export var malware_icon := VBoxContainer
@export var decr_icon := VBoxContainer
@export var key_icon := VBoxContainer
@export var decrypted_message := Label

signal boilerplate
signal listener

func _ready() -> void:
	current_tab = 11

func _on_window_container_ransomware_start() -> void:
	current_tab = 1

func _on_password_check_component_correct_password() -> void:
	current_tab = 0
	malware_icon.visible = true
	decr_icon.visible = true
	key_icon.visible = true
	decrypted_message.visible = true

func _on_desktop_default_cyberattack_selected(cyberattack: Variant) -> void:
	match cyberattack:
		"Ransomware":
			current_tab = 1
			
		"Bruteforce":
			current_tab = 4
		
		"Phishing":
			current_tab = 7

		"Fileless":
			current_tab = 5
		
		"DOS":
			current_tab = 9

func _on_window_window_exited() -> void:
	current_tab = 2

func _on_post_ransomware_encrypt_post_ransomware_encrypt_exited() -> void:
	current_tab = 3

func _on_ransomware_decrypt_ransomware_decrypt_finished() -> void:
	current_tab = 0

func _on_fileless_scene_change() -> void:
	current_tab = 6

func _on_terminal_boilerplate() -> void:
	current_tab = 5 
	emit_signal("boilerplate")

func _on_terminal_listener() -> void:
	current_tab = 5
	emit_signal("listener")

func _on_phishing_change_to_website() -> void:
	current_tab = 8

func _on_phishing_website_change_to_terminal() -> void:
	current_tab = 7

func _on_login_login_successful() -> void:
	current_tab = 0

func _on_ddos_change_to_result() -> void:
	current_tab = 10
