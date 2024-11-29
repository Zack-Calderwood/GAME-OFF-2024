extends Resource

class_name Inv

signal update

@export var items: Array[InvItem]

func insert(item: InvItem):
	items.push_back(item)
	update.emit()

	
