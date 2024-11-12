extends Camera2D

@export var player: Node2D

@export var enemy: Node2D

var follow_speed = 1.75

var mouse_offset_distance = 50.0

@export var randomStrength: float = 1
@export var shakeFade: float = 5.0

var shake_strength: float = 0.0

var rng = RandomNumberGenerator.new()

var new_value: float = 0.0

var current_value: float = 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	camera_movement(delta)
	current_value = adjust_value_by_distance(current_value, 0, 100, 200, 0.1)
	current_value = new_value
	
	apply_shake()

	pass
	
func camera_movement(delta: float) -> void:

	var target_position = player.position

	var mouse_pos = get_global_mouse_position()
	var direction_to_mouse = (mouse_pos - player.position).normalized()

	target_position += direction_to_mouse * mouse_offset_distance

	global_position = global_position.lerp(target_position, follow_speed * delta)
	
	camera_shake(delta)

func apply_shake() -> void : 
	if enemy.get_state() == 1: #change later 1 == EnemyState.chase
		shake_strength = randomStrength
	
func randomOffset() -> Vector2:
	return Vector2(rng.randf_range(-shake_strength, shake_strength),rng.randf_range(-shake_strength, shake_strength))

func camera_shake(delta: float) -> void: 
	if shake_strength > 0:
		shake_strength = lerpf(shake_strength,0,shakeFade * delta)
		
		offset = randomOffset()
		
func adjust_value_by_distance(current_value: float, min_value: float, max_value: float, max_distance: float, speed: float) -> float:

	var distance = $"..".position.distance_to($"../../Enemy".position)
	
	var distance_factor = clamp(1.0 - distance / max_distance, 0, 1)
	
	var new_value = lerp(min_value, max_value, distance_factor)
	
	current_value = lerp(current_value, new_value, speed)
	
	
	randomStrength = current_value
	print(randomStrength)
	
	# Debug prints
	return current_value
