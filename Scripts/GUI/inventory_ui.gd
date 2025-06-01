extends Control

@onready var slots : Array = $InventoryItems/GridContainer.get_children()
@onready var inventory_description = $InventoryDescription
@onready var inv : Inv = preload("res://Items/player_inventory.tres")

func _ready() -> void:
	GameManager.inv = self
	update_slots()
	GameManager.ui_active = false
	close()

func add(item : InvItem):
	print("ADDED")
	inv.add(item)
	update_slots()

func _on_slot_clicked(description, name):
	inventory_description.item_name.text = name
	inventory_description.item_description.text = description
	
func clear_description():
	inventory_description.item_name.text = ""
	inventory_description.item_description.text = ""

func update_slots():
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
