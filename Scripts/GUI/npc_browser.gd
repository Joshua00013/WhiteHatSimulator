extends Control


@onready var downloads = $Downloads
@onready var email = $Email

@onready var real_website = $Background/RealWebsite
@onready var page = $Background/Page
@onready var piracy = $Background/Piracy
@onready var data_server = $Background/DatabaseWebsite

@onready var links = $Background/SearchBar/ButtonsContainer/Panel/Links
@onready var email_label = $Email/MarginContainer/HBoxContainer/Label
@onready var download_item = $Downloads/VBoxContainer/DownloadItem

var id : int
var server_computer := false
var email_address : String = ""
var email_seen : bool = false
var pirating : bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	email.hide()
	downloads.hide()
	piracy.hide()
	data_server.hide()
	download_item.hide()

func change_email(new_email : String):
	email_address = new_email
	email_label.text = email_address

func initialize_server(state : bool):
	if state == false:
		return
	else:
		links.add_item("https://db.cascadecorp.internal/api/v1", 3)

func initialize_piracy(state : bool):
	if state == false || CyberattackAdaptationManager.piracy_exploited == true:
		download_item.hide()
		return
	elif state == true && CyberattackAdaptationManager.piracy_exploited == false :
		links.add_item("https://www.6556x.com", 2)
		pirating = true
		download_item.show()

func _on_user_toggled(toggled_on):
	if email_seen == false && email_address != null:
		CyberattackManager.reconnaissance_finished = true
		CyberattackManager.set_email_usable(email_address, true)
		UiManager.popup.display_popup("Good job!", "You have found an employee's email.", false)
		email_seen = true
	if downloads.visible == true:
		downloads.hide()
		
	email.visible = toggled_on

func hide_websites():
	page.hide()
	piracy.hide()
	real_website.hide()
	data_server.hide()

func _on_links_item_selected(index):
	CyberattackManager.reconnaissance_finished = true
	id = links.get_item_id(index)
	match id:
		1:
			UiManager.popup.display_popup("Good job!", "You have found the company website.", false)
			CyberattackManager.website_seen = true
			hide_websites()
			real_website.show()
			
		2:
			UiManager.popup.display_popup("Good job!", "You have found the piracy website.", false)
			CyberattackManager.piracy_seen = true
			hide_websites()
			piracy.show()
			
		3:
			UiManager.popup.display_popup("Good job!", "You have found the database website.", false)
			CyberattackManager.data_server_seen = true
			hide_websites()
			data_server.show()


func _on_downloads_pressed(toggled_on : bool):
	if email.visible == true:
		email.hide()
	if pirating == true:
		CyberattackManager.piracy_seen = true
	downloads.visible = toggled_on
