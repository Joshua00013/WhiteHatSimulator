extends Control

@export var email_options : OptionButton
@export var attachment_type : OptionButton
@export var body : RichTextLabel
@export var send_button : Button

@onready var cyberattack_player = $CyberattackPlayer

enum Attachments { PHISHING, RANSOMWARE, FILELESS }
func _ready():
	email_options.connect("pressed", update_email_buttons)
	send_button.connect("pressed", _on_email_sent)
	cyberattack_player.connect("animation_finished",_on_animation_finished)
	attachment_type.connect("item_selected",play_cyberattack_animation)
	attachment_type.connect("pressed", update_attachment_options)
	
	send_button.disabled = true
	body.text = ""
	
	update_email_buttons()
	update_attachment_options()

func update_email_buttons():
	email_options.clear() # remove old items
	var usable := CyberattackManager.get_usable_emails()
	for address in usable:
		email_options.add_item(address)

func update_attachment_options():
	attachment_type.set_item_disabled(Attachments.PHISHING, not CyberattackManager.phishing_ready)
	attachment_type.set_item_disabled(Attachments.RANSOMWARE, not CyberattackManager.ransomware_ready)
	attachment_type.set_item_disabled(Attachments.FILELESS, not CyberattackManager.fileless_ready)

func play_cyberattack_animation(index : int):
	if email_options.get_selected_id() == -1: 
		print("No email selected, skipping animation") 
		return
	match index:
		Attachments.PHISHING:
			cyberattack_player.play("phishing_email")
		Attachments.RANSOMWARE:
			cyberattack_player.play("ransomware_email")
		Attachments.FILELESS:
			cyberattack_player.play("fileless_email")

func _on_animation_finished(animation : String):
	send_button.disabled = false

func _on_email_sent():
	if CyberattackAdaptationManager.phishing_used == false:
		CyberattackManager.delivery_finished = true
		CyberattackAdaptationManager.phishing_used = true
		#TODO : Animation showing myrione logged in 
