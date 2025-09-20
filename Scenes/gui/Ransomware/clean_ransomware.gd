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
	"DOS": 10,
	"Login" : 11
	# TODO : Add all page names here to avoid magic numbers and use the dictionary instead
}

func _ready() -> void:
	SignalBus.fileless_part1_finished.connect(_fileless_desktop)
	SignalBus.fileless_part2_finished.connect(_fileless_terminal)
	SignalBus.phishing_part1_finished.connect(_phishing_desktop)
	SignalBus.phishing_part2_finished.connect(_phishing_website)
	SignalBus.phishing_part3_finished.connect(_phishing_terminal)
	SignalBus.ddos_part1_finished.connect(_ddos_desktop)
	SignalBus.cyberattack_selected.connect(_on_cyberattack_selected)
	current_tab = TABS.Login

func _on_cyberattack_selected(cyberattack: String) -> void:
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

func _on_login_login_successful() -> void:
	current_tab = 0

func _fileless_desktop():
	current_tab = 6
	
func _fileless_terminal():
	current_tab = TABS.Fileless
	
func _phishing_desktop():
	current_tab = 12
	
func _phishing_website():
	current_tab = 8

func _phishing_terminal():
	current_tab = TABS.Phishing

func _ddos_desktop():
	current_tab = TABS.DOS
