extends Control

signal email_btn_pressed
signal upload_btn_pressed
signal website_btn_pressed

@export var email_btn : Button
@export var upload_btn : Button
@export var website_btn : Button

@export var email : Control
func _ready():
	CyberattackManager.email_updated.connect(update_buttons)
	CyberattackManager.website_seen_changed.connect(update_buttons)
	CyberattackManager.piracy_seen_changed.connect(update_buttons)
	update_buttons()

func _on_send_button_pressed():
	pass # Replace with function body.

func update_buttons():
	var useable = CyberattackManager.get_usable_emails()
	
	# Email button
	if useable.is_empty():
		email_btn.disabled = true
	else:
		email_btn.disabled = false  # Enable if there is at least one usable email
	# Website button
	if not CyberattackManager.website_seen:
		website_btn.disabled = true
	else:
		website_btn.disabled = false
	# Upload button
	if not CyberattackManager.piracy_seen:
		upload_btn.disabled = true
	else:
		upload_btn.disabled = false



#TODO : Add piracy page and website hosting page. Create animations for uploading to piracy page then play the laptop animations
# based on the type used
