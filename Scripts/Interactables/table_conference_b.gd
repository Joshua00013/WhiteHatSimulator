extends Node3D

@export var laptop : PackedScene
@export var laptop_item : InvItem

@onready var laptop_ghost = $LaptopGhost

func _on_interactable_interact_triggered():
	if GameManager.remove_item(laptop_item) == true:
		laptop_ghost.visible = false
		spawn_laptop()

func spawn_laptop():
	var new_laptop = laptop.instantiate()
	add_child(new_laptop)
	
	new_laptop.position = Vector3(-1.3, 1.835, 0)
	new_laptop.rotation = Vector3(0,deg_to_rad(90),0)
	new_laptop.connect("closed",show_ghost)

func show_ghost():
	laptop_ghost.visible = true
