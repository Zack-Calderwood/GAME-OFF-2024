extends Camera2D

@export var player: Node2D

var follow_speed = 1.0

var mouse_offset_distance = 100.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	camera_movement(delta)
	pass
	
func camera_movement(delta: float) -> void:

	var target_position = player.position

	var mouse_pos = get_global_mouse_position()
	var direction_to_mouse = (mouse_pos - player.position).normalized()

	target_position += direction_to_mouse * mouse_offset_distance

	global_position = global_position.lerp(target_position, follow_speed * delta)
