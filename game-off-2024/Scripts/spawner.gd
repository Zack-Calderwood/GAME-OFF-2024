extends Node2D

var footStepNode = preload("res://Scenes/foot_step.tscn")

@export var note: PackedScene
@export var enemy_node: Node2D
@export var game_manager_path: NodePath

var spawnedObject = true

func _process(delta: float) -> void:
	if spawnedObject:
		spawn_notes()
	pass

func spawn_footsteps(position: Vector2):

	var footstep_instance = footStepNode.instantiate()
	
	footstep_instance.position = position
	
	get_parent().add_child(footstep_instance)
	
func _on_timer_timeout() -> void:
	spawn_footsteps(enemy_node.global_position)
	pass # Replace with function body.
	
func spawn_notes()-> void:
	for i in range(6):
		var note_instance = note.instantiate()
		
		note_instance.position = Vector2(randf_range(-500.0, 500.0), randf_range(-300.0, 300.0))
		
		get_parent().add_child(note_instance)
		
		var game_manager = get_node(game_manager_path)
		game_manager.add_spawned_object(note_instance)
		
	spawnedObject = false
	pass
