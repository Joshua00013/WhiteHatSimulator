extends Node

signal phase_updated(phase: String)
signal cyberattack_ready(attack_name: String)
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

var website_seen := false
var piracy_seen := false

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

func get_usable_emails() -> Array:
	var usable := []
	for address in emails.keys():
		if emails[address] == true:
			usable.append(address)
	return usable
	
func set_reconnaissance(value: bool) -> void:
	if not reconnaissance_finished and value:
		reconnaissance_finished = true
		emit_signal("phase_updated", "reconnaissance")

func set_weaponization(value: bool) -> void:
	if reconnaissance_finished and not weaponization_finished and value:
		weaponization_finished = true
		emit_signal("phase_updated", "weaponization")

func set_delivery(value: bool) -> void: # True upon accessing a computer, selecting a deployment button from laptop
	if weaponization_finished and not delivery_finished and value:
		delivery_finished = true
		emit_signal("phase_updated", "delivery")
		UiManager.popup.display_popup("Delivery Phase Finished", "You have found a way to deliver a cyberattack", false )

func set_exploitation(value: bool) -> void: # True upon the start of deployment attempt
	if not exploitation_finished and value:
		exploitation_finished = true
		emit_signal("phase_updated", "exploitation")

func set_installation(value: bool) -> void: # True after a successful deployment
	if not installation_finished and value:
		installation_finished = true
		emit_signal("phase_updated", "installation")

func set_command_and_control(value: bool) -> void: # True immediately after installation or opening a laptop to access a pc
	if not command_and_control_finished and value:
		command_and_control_finished = true
		emit_signal("phase_updated", "command_and_control")

func set_actions_on_objectives(value: bool) -> void: # Tell the player to head out of the door to evaluate the system
	if not actions_on_objectives_finished and value:
		actions_on_objectives_finished = true
		emit_signal("phase_updated", "actions_on_objectives")

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
