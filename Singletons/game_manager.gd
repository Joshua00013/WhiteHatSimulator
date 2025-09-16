extends Node

signal ui_updated
@warning_ignore("unused_signal")
signal item_stolen

@onready var emulate_mouse = ProjectSettings.get_setting("input_devices/pointing/emulate_mouse_from_touch")

var ui_active : bool = false : #Variable for checking if theres an active ui. Defaulted to false as the player doesnt spawn with UI on
	set(value):
		ui_active = value
		ui_updated.emit(value)

var stage_finished : bool = false # Being set in main script ready to be false
var game_paused : bool = false # Variable for pausing the game
var is_crouching :bool = false
var android_ui : CanvasLayer
var player_camera : Camera3D
var player : CharacterBody3D
var inv : Control

func _ready():
	match OS.get_name():
		"Windows":
			ProjectSettings.set_setting("input_devices/pointing/emulate_mouse_from_touch", false)
		"Android":
			ProjectSettings.set_setting("input_devices/pointing/emulate_mouse_from_touch", true)

func reset():
	stage_finished = false
	is_crouching= false
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
