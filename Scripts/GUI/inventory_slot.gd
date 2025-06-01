extends Panel

@onready var button = $Button
@onready var label = $Label
var slot_item : InvItem

signal slot_clicked

func _ready():
	button.button_down.connect(Callable(self, "_on_button_button_down")) 

func update(item:InvItem):
	if !item:
		label.visible = false
	else:
		slot_item = item
		label.visible = true
		label.text = item.name

func _on_button_button_down():
	if slot_item != null:
		emit_signal("slot_clicked", slot_item.description, slot_item.name)
