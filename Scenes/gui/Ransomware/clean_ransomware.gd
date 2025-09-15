extends TabContainer

@onready var desktop_default: MarginContainer = $DesktopDefault
@export var malware_icon := VBoxContainer

signal boilerplate
signal listener

const TABS := {
	"Ransomware": 1,
	"RansomwareEncrypt": 2,
	"RansomwareDecrypt" : 3,
	"Bruteforce": 4,
	"Phishing": 7,
	"Fileless": 5,
	"DOS": 9,
	"Login" : 11
}

func _ready() -> void:
	current_tab = TABS.Login

func _on_desktop_default_cyberattack_selected(cyberattack: Variant) -> void:
	match cyberattack:
		"Ransomware":
			current_tab = TABS.Ransomware
			
		"Bruteforce":
			current_tab = TABS.Bruteforce
		
		"Phishing":
			current_tab = TABS.Phishing

		"Fileless":
			current_tab = TABS.Fileless
		
		"DOS":
			current_tab = TABS.DOS
	UiManager.show_nav_buttons.emit()

func _on_window_window_exited() -> void:
	current_tab = 2

func _on_post_ransomware_encrypt_post_ransomware_encrypt_exited() -> void:
	current_tab = 3

func _on_weaponization_finished() -> void:
	UiManager.popup.display_popup("Good Job!", "Weaponization is now finished. Now deploy your cyberattack", false)
	CyberattackManager.weaponization_finished = true
	desktop_default.hide_cards()
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

func _on_phishing_website_change_to_deployment() -> void:
	current_tab = 12
