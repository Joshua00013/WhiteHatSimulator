extends Resource

class_name Inv

@export var items : Array[InvItem]

func add(item: InvItem):
	for i in range(items.size()):
		print("Insert function")
		if !items[i]: #true if items[i] is null, false or empty. If empty then add the item to the slot
			items[i] = item
			return #stop after inserting
