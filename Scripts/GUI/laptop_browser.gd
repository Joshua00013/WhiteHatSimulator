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

func _on_email_button_pressed():
	email.show()


func _on_upload_button_pressed():
	pass # Replace with function body.


func _on_website_button_pressed():
	pass # Replace with function body.


# EMAIL SUCCESS EVENTS -- CONNECTED TO THE MAIN NODE TO TRIGGER ANIMATIONS ON SCREEN

func _on_email_fileless_sent():
	UiManager.laptop_play_fileless.emit()


func _on_email_phishing_sent():
	UiManager.laptop_play_phishing.emit()


func _on_email_ransomware_sent():
	UiManager.laptop_play_ransomware.emit()

#TODO : Add piracy page and website hosting page. Create animations for uploading to piracy page then play the laptop animations
# based on the type used
