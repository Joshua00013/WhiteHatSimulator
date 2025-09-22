extends Control

@export var settings : Control
@onready var name_container = $NameContainer
@onready var load_container = $LoadContainer

func _ready():
	DayAndNightManager.active = false

func _on_start_pressed():
	name_container.show()

func _on_load_pressed():
	load_container.refresh_saves()
	load_container.show()

func _on_settings_pressed():
	settings.show()

func _on_quit_pressed():
	get_tree().quit()
