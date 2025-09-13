extends Node

signal phase_updated(phase: String)

var reconnaissance_finished: bool = false : set = set_reconnaissance
var weaponization_finished: bool = false : set = set_weaponization
var delivery_finished: bool = false : set = set_delivery
var exploitation_finished: bool = false : set = set_exploitation
var installation_finished: bool = false : set = set_installation
var command_and_control_finished: bool = false : set = set_command_and_control
var actions_on_objectives_finished: bool = false : set = set_actions_on_objectives

var ransomware_ready : bool = false
var bruteforce_ready : bool = false
var phishing_ready : bool = false
var fileless_ready : bool = false
var dos_ready : bool = false

func set_reconnaissance(value: bool) -> void:
	if not reconnaissance_finished and value:
		reconnaissance_finished = true
		emit_signal("phase_updated", "reconnaissance")

func set_weaponization(value: bool) -> void:
	if not weaponization_finished and value:
		weaponization_finished = true
		emit_signal("phase_updated", "weaponization")

func set_delivery(value: bool) -> void:
	if not delivery_finished and value:
		delivery_finished = true
		emit_signal("phase_updated", "delivery")

func set_exploitation(value: bool) -> void:
	if not exploitation_finished and value:
		exploitation_finished = true
		emit_signal("phase_updated", "exploitation")

func set_installation(value: bool) -> void:
	if not installation_finished and value:
		installation_finished = true
		emit_signal("phase_updated", "installation")

func set_command_and_control(value: bool) -> void:
	if not command_and_control_finished and value:
		command_and_control_finished = true
		emit_signal("phase_updated", "command_and_control")

func set_actions_on_objectives(value: bool) -> void:
	if not actions_on_objectives_finished and value:
		actions_on_objectives_finished = true
		emit_signal("phase_updated", "actions_on_objectives")
