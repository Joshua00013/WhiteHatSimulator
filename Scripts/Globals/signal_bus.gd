extends Node

@warning_ignore("unused_signal")
signal stage_finished
signal intro_finished

var current_step_1 = 1
var current_step_2 = 2
var current_step_3 = 3
var current_step_4 = 4

var terminal_not_finished = false

#EXAMPLE
@warning_ignore("unused_signal")
signal ransomware_encrypt_finished # PWEDE NA NI MACKY I EMIT KAHIT SAN. 
@warning_ignore("unused_signal")
signal ransomware_desktop_exited
@warning_ignore("unused_signal")
signal ransomware_decrypt_finished

signal cyberattack_selected(cyberattack : String)
signal website_seen
signal piracy_seen

signal ransomware_email_sent (email : String)
signal fileless_email_sent (email : String)
signal phishing_email_sent (email : String)

signal ransomware_uploaded # Only used for piracy
signal fileless_uploaded

@warning_ignore("unused_signal")
signal fileless_part1_finished
@warning_ignore("unused_signal")
signal fileless_part2_finished
@warning_ignore("unused_signal")
signal phishing_part1_finished
@warning_ignore("unused_signal")
signal phishing_part2_finished
@warning_ignore("unused_signal")
signal phishing_part3_finished
@warning_ignore("unused_signal")
signal phishing_part4_finished
@warning_ignore("unused_signal")
signal ddos_part1_finished

@warning_ignore("unused_signal")
signal phishing_site_hosted
#PANO I CONNECT:
#SCRIPT NG CODE NA NAGLILISTEN:
# func _ready()
	#signal_bus.ransomware_encrpyt_finished.connect(_on_ransomware_encrpyt_finished)
	#
#func _on_ransomware_encrpt_finished():
	#print("Do something here")
	
#PANO I EMIT:
#	_my_function(): -> pwedeng end ng animation etc.
#		Signal_Bus.ransomware_encrypt_finished.emit()
