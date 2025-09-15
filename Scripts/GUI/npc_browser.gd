extends Control

@onready var email = $Email
@onready var email_label = $Email/MarginContainer/HBoxContainer/Label

var email_address : String = ""
var email_seen : bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	email.hide()

func change_email(new_email : String):
	email_address = new_email
	email_label.text = email_address

func _on_user_toggled(toggled_on):
	if email_seen == false && email_address != null:
		CyberattackManager.reconnaissance_finished = true
		CyberattackManager.emails[email_address] = true
		UiManager.popup.display_popup("Good job!", "You have found an employee's email.", false)
		email_seen = true
	email.visible = toggled_on


func _on_links_item_selected(index):
	CyberattackManager.reconnaissance_finished = true
	match index:
		1:
			UiManager.popup.display_popup("Good job!", "You have found the company website.", false)
			CyberattackManager.website_seen = true
			# TODO : Add a website for the company
		2:
			UiManager.popup.display_popup("Good job!", "You have found the piracy website.", false)
			CyberattackManager.piracy_seen = true
			# TODO : Add a website for piracy
