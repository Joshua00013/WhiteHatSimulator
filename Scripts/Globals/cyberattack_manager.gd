extends Node

signal phase_updated(phase: String)
signal cyberattack_ready(attack_name: String)
signal piracy_seen_changed
signal website_seen_changed
signal data_server_seen_changed
signal phishing_site_hosted_changed
signal email_updated (address, value)

var current_phase : String = "reset"

var reconnaissance_finished: bool = false : set = set_reconnaissance
var weaponization_finished: bool = false : set = set_weaponization
var delivery_finished: bool = false : set = set_delivery
var exploitation_finished: bool = false : set = set_exploitation
var installation_finished: bool = false : set = set_installation
var command_and_control_finished: bool = false : set = set_command_and_control
var actions_on_objectives_finished: bool = false : set = set_actions_on_objectives

var ransomware_ready : bool = false : set = set_ransomware_ready
var bruteforce_ready : bool = false : set = set_bruteforce_ready
var phishing_ready : bool = false : set = set_phishing_ready
var fileless_ready : bool = false : set = set_fileless_ready
var dos_ready : bool = false : set = set_dos_ready

var website_seen := false : set = set_website_seen
var piracy_seen := false : set = set_piracy_seen
var data_server_seen := false : set = set_data_server_seen
var phishing_site_hosted := false : set = set_phishing_site_hosted

var server_room_password : String
# Dictionary of emails and whether they are usable
var emails := {
	"al@company.com": false,
	"brian@company.com": false,
	"gigi@company.com": false,
	"joe@company.com": false,
	"john@company.com": false,
	"koro@company.com": false,
	"liz@company.com": false,
	"mike@company.com": false,
	"mococo@company.com": false,
	"myrione@company.com": false,
	"robert@company.com": false,
	"sai@company.com": false,
	"shion@company.com": false,
	"walter@company.com": false,
	"wisadel@company.com": false
}

func reset():
	current_phase = "reset"
	
	reconnaissance_finished = false
	weaponization_finished = false
	delivery_finished = false
	exploitation_finished = false
	exploitation_finished = false
	installation_finished = false
	command_and_control_finished = false
	actions_on_objectives_finished = false
	
	ransomware_ready = false
	bruteforce_ready = false
	phishing_ready = false
	fileless_ready = false
	dos_ready = false
	
	website_seen = false
	piracy_seen = false
	data_server_seen = false
	phishing_site_hosted = false
	
	emails = {
	"al@company.com": false,
	"brian@company.com": false,
	"gigi@company.com": false,
	"joe@company.com": false,
	"john@company.com": false,
	"koro@company.com": false,
	"liz@company.com": false,
	"mike@company.com": false,
	"mococo@company.com": false,
	"myrione@company.com": false,
	"robert@company.com": false,
	"sai@company.com": false,
	"shion@company.com": false,
	"walter@company.com": false,
	"wisadel@company.com": false
	}
	
	phase_updated.emit("reset")

func set_phishing_site_hosted(value : bool):
	phishing_site_hosted = value
	phishing_site_hosted_changed.emit()

func set_data_server_seen(value: bool) -> void:
	data_server_seen = value
	data_server_seen_changed.emit(value)


func set_website_seen(value: bool) -> void:
	website_seen = value
	website_seen_changed.emit(value)

func set_piracy_seen(value: bool) -> void:
	print("piracy_seen setter called with:", value, " (from:", get_stack(), ")")
	piracy_seen = value
	piracy_seen_changed.emit(value)

func set_email_usable(address: String, value: bool) -> void:
	if emails.has(address):
		emails[address] = value
		email_updated.emit(address, value)

func get_usable_emails() -> Array:
	var usable := []
	for address in emails.keys():
		if emails[address] == true:
			usable.append(address)
	return usable

func set_reconnaissance(value: bool) -> void:
	if not reconnaissance_finished and value:
		reconnaissance_finished = true
		current_phase = "reconnaissance"
		emit_signal("phase_updated", "reconnaissance")
	elif value == false:
		reconnaissance_finished = false

func set_weaponization(value: bool) -> void:
	if reconnaissance_finished and not weaponization_finished and value:
		weaponization_finished = true
		current_phase = "weaponization"
		emit_signal("phase_updated", "weaponization")
	elif value == false:
		weaponization_finished = false

func set_delivery(value: bool) -> void: # True upon accessing a computer, selecting a deployment button from laptop
	if weaponization_finished and not delivery_finished and value:
		delivery_finished = true
		current_phase = "delivery"
		emit_signal("phase_updated", "delivery")
		UiManager.popup.display_popup("Delivery Phase Finished", "You have found a way to deliver a cyberattack", false )
	elif value == false:
		delivery_finished = false

func set_exploitation(value: bool) -> void: # True upon the start of deployment attempt
	if not exploitation_finished and value:
		exploitation_finished = true
		current_phase = "exploitation"
		emit_signal("phase_updated", "exploitation")
		UiManager.popup.display_popup("Exploitation Phase Finished", "You are now exploiting the system", false )
	elif value == false:
		exploitation_finished = false

func set_installation(value: bool) -> void: # True after a successful deployment
	if not installation_finished and value:
		installation_finished = true
		current_phase = "installation"
		emit_signal("phase_updated", "installation")
		UiManager.popup.display_popup("Installation Phase Finished", "You have installed the cyberattack", false )
	elif value == false:
		installation_finished = false

func set_command_and_control(value: bool) -> void: # True immediately after installation or opening a laptop to access a pc. Can fail if theres antivirus
	if not command_and_control_finished and value:
		command_and_control_finished = true
		current_phase = "command_and_control"
		emit_signal("phase_updated", "command_and_control")
		UiManager.popup.display_popup("Command and Control Phase Finished", "Your cyberattack persisted against the defenses", false )
	elif value == false:
		command_and_control_finished = false

func set_actions_on_objectives(value: bool) -> void: # Tell the player to head out of the door to evaluate the system
	if not actions_on_objectives_finished and value:
		actions_on_objectives_finished = true
		current_phase = "actions_on_objectives"
		emit_signal("phase_updated", "actions_on_objectives")
		GameManager.stage_finished = true
	elif value == false:
		actions_on_objectives_finished = false

## Setters for the cyberattacks: -------------------------------------------------

func set_ransomware_ready(value: bool) -> void:
	ransomware_ready = value
	if value:
		emit_signal("cyberattack_ready", "ransomware")

func set_bruteforce_ready(value: bool) -> void:
	bruteforce_ready = value
	if value:
		emit_signal("cyberattack_ready", "bruteforce")

func set_phishing_ready(value: bool) -> void:
	phishing_ready = value
	if value:
		emit_signal("cyberattack_ready", "phishing")

func set_fileless_ready(value: bool) -> void:
	fileless_ready = value
	if value:
		emit_signal("cyberattack_ready", "fileless")

func set_dos_ready(value: bool) -> void:
	dos_ready = value
	if value:
		emit_signal("cyberattack_ready", "dos")
