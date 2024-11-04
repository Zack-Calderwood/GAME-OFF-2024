extends Node2D

var footStepNode = preload("res://Scenes/foot_step.tscn")

@export var enemy_node: Node2D

func spawn_node(position: Vector2):

	var node_instance = footStepNode.instantiate()
	
	node_instance.position = position
	
	get_parent().add_child(node_instance)
	
	print("Node spawned at position: ", position)

func _on_timer_timeout() -> void:
	spawn_node(enemy_node.global_position)
	
	
	pass # Replace with function body.
