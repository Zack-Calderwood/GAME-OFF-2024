extends PointLight2D

# Reference to the player node
@onready var player = $".."

var radius = 30.0

var move_lerp_speed  = 5.0

var rotate_lerp_speed = 5.0



func _process(delta: float) -> void:
	#if the mouse button is clicked toggle the flash light on or off
	
		

	
	var mouse_pos = get_global_mouse_position()
	
	var direction = (mouse_pos - player.position).normalized()
	
	var target_position = player.position + direction * radius
	
	global_position = global_position.lerp(target_position, move_lerp_speed * delta)
	
	var target_rotation = direction.angle()
	
	rotation = lerp_angle(rotation, target_rotation, rotate_lerp_speed * delta)
	
	pass
	
