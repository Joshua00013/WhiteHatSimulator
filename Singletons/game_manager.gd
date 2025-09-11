extends Node

signal ui_updated
signal item_stolen

@onready var emulate_mouse = ProjectSettings.get_setting("input_devices/pointing/emulate_mouse_from_touch")

var ui_active : bool = false : #Variable for checking if theres an active ui. Defaulted to false as the player doesnt spawn with UI on
	set(value):
		ui_active = value
		ui_updated.emit(value)

var game_paused : bool = false # Variable for pausing the game
var is_crouching :bool = false
var android_ui : CanvasLayer
var player_camera : Camera3D
var player : CharacterBody3D
var inv : Control


@export var test_item: InvItem
func _ready():
	match OS.get_name():
		"Windows":
			ProjectSettings.set_setting("input_devices/pointing/emulate_mouse_from_touch", false)
		"Android":
			ProjectSettings.set_setting("input_devices/pointing/emulate_mouse_from_touch", true)
	adjust_screen_size()

#TODO : Function for removing inventory item. Emit a signal for inventory update

func add_item(item:InvItem):
	inv.add(item)

func remove_item(item:InvItem):
	return inv.remove(item)

func check_inv(item:InvItem):
	return inv.check_inv(item)
	
func dialogue_remove_item(target_item: String):
	var item : InvItem
	match target_item:
		"Coffee":
			item = load("res://Items/coffee.tres")
		"Pass":
			item = load("res://Items/pass.tres")
	inv.remove(item)

func dialogue_add_item(target_item: String):
	var item : InvItem
	match target_item:
		"Coffee":
			item = load("res://Items/coffee.tres")
		"Pass":
			item = load("res://Items/pass.tres")
	inv.add(item)

func adjust_screen_size():
	var screen_size = DisplayServer.screen_get_size()
	var win = get_window()
	
	# Whatever resolution you want by default
	var desired = Vector2i(1152, 720)

	# Clamp so it NEVER goes bigger than the monitor
	var auto_size = Vector2i(
		min(desired.x, screen_size.x),
		min(desired.y, screen_size.y)
	)

	win.size = auto_size
	win.position = Vector2i(
		(screen_size.x - auto_size.x) / 2,
		(screen_size.y - auto_size.y) / 2
	) # center it on screen
