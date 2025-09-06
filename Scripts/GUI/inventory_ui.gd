extends Control

var slots : Array

@export var slot_container : GridContainer
@export var item_name : Label
@export var item_description : Label

@onready var inv : Inv = preload("res://Items/player_inventory.tres")

func _ready() -> void:
	GameManager.inv = self
	update_slots()
	GameManager.ui_active = false
	close()

func add(item : InvItem):
	inv.add(item)
	update_slots()
	
func remove(item:InvItem):
	if inv.remove(item) == true:
		call_deferred("update_slots")
		return true
	else:
		return false

func check_inv(item : InvItem):
	inv.check_inv(item)
	
func _on_slot_clicked(description, inv_item_name):
	item_name.text = inv_item_name
	item_description.text = description
	
func clear_description():
	item_name.text = ""
	item_description.text = ""

func update_slots():
	slots = slot_container.get_children()
	
	for slot in slots:
		slot.slot_clicked.connect(self._on_slot_clicked)
	
	for i in range(min(inv.items.size(), slots.size())):
		slots[i].update(inv.items[i])

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("inventory"):
		if GameManager.ui_active == true:
			close()
		else:
			open()

func open():
	visible = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	GameManager.ui_active = true

func close():
	visible = false
	clear_description()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	GameManager.ui_active = false
