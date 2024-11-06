extends Node2D



var spawned_objects = []
var score = 0

func _ready() -> void:
	Events.note_Picked_Up.connect(remove_spawned_object)

#spawns in notes to the map
func add_spawned_object(object):
	spawned_objects.append(object)

#removes note from the array when player picks it up
func remove_spawned_object(object):
	score += 1
	print("you have" , score , " notes")
	spawned_objects.remove_at(spawned_objects.find(object))

#adds spawned notes to array for monster tracking
func get_spawned_objects() -> Array:
	return spawned_objects


	
