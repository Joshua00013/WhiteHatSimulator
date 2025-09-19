extends Control

@export var searchbar : OptionButton

var website_added : bool = false

func _ready():
	SignalBus.website_seen.connect(_on_website_seen)
	if CyberattackManager.website_seen == true:
		_on_website_seen() # On reload, if the website seen var is true, add the link to the searchbar

func _on_website_seen():
	if not website_added:
		searchbar.add_item("https://www.pulseforge-studio.com", 1)
		website_added = true
