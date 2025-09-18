extends TabContainer

@onready var desktop_default: MarginContainer = $DesktopDefault
@export var malware_icon := VBoxContainer

signal boilerplate
signal listener

const TABS := {
	"Ransomware": 1,
	"PostRansomwareEncrypt": 2,
	"RansomwareDecrypt" : 3,
	"Bruteforce": 4,
	"Phishing": 7,
	"Fileless": 5,
	"DOS": 9,
	"Login" : 11
	# TODO : Add all page names here to avoid magic numbers and use the dictionary instead
}

func _ready() -> void:
	SignalBus.cyberattack_selected.connect(_on_cyberattack_selected)
	current_tab = TABS.Login

func _on_cyberattack_selected(cyberattack: String) -> void:
	match cyberattack:
		"Ransomware":
			current_tab = TABS.Fileless
			
		"Bruteforce":
			current_tab = TABS.Bruteforce
		
		"Phishing":
			current_tab = TABS.Phishing

		"Fileless":
			current_tab = TABS.Fileless
		
		"DOS":
			current_tab = TABS.DOS
	UiManager.show_nav_buttons.emit()

func _on_weaponization_finished() -> void:
	UiManager.popup.display_popup("Good Job!", "Weaponization is now finished. Now deploy your cyberattack", false)
	CyberattackManager.weaponization_finished = true
	desktop_default.hide_cards()
	current_tab = 0

func _on_window_window_exited() -> void:
	current_tab = TABS.PostRansomwareEncrypt
	UiManager.popup.display_popup("Encryption finished", "Now the files have been encrypted. The files should only display a hash when opened. Press next to proceed",false)

func _on_post_ransomware_encrypt_post_ransomware_encrypt_exited() -> void:
	current_tab = TABS.RansomwareDecrypt
	
func _on_fileless_scene_change() -> void:
	current_tab = 6


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

func _on_fileless_desktop_from_desktop_to_ide() -> void:
	current_tab = 5
