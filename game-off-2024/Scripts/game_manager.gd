extends Node2D

var spawned_objects = []

func add_spawned_object(object):
	spawned_objects.append(object)


func get_spawned_objects() -> Array:
	return spawned_objects
