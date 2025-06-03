extends Node


@onready var emulate_mouse = ProjectSettings.get_setting("input_devices/pointing/emulate_mouse_from_touch")

var ui_active : bool = false #Variable for checking if theres an active ui. Defaulted to false as the player doesnt spawn with UI on
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

func add_item(item:InvItem):
	inv.add(item)
