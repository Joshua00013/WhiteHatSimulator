extends Resource

class_name Inv

@export var items : Array[InvItem]

func add(item: InvItem):
	for i in range(items.size()):
		if !items[i]: #true if items[i] is null, false or empty. If empty then add the item to the slot
			items[i] = item
			return #stop after inserting

func remove(target_item: InvItem):
	for i in range(items.size()): #If item is already in the inventory, decrease the (int)amount variable instead of that item
		if items[i] == target_item: #If we found the item we are looking for and the amount is more than the quantity
			items[i] = null
			return true


func check_inv(target_item: InvItem):
	for i in range(items.size()):
		if items[i] == target_item:
			return true
	return false
