extends Camera2D

@export var player: Node2D

var follow_speed = 1.75

var mouse_offset_distance = 50.0


@export var randomStrength: float = 1
@export var shakeFade: float = 5.0

var shake_strength: float = 0.0

var rng = RandomNumberGenerator.new()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	camera_movement(delta)
	#apply_shake()
	pass
	
func camera_movement(delta: float) -> void:

	var target_position = player.position

	var mouse_pos = get_global_mouse_position()
	var direction_to_mouse = (mouse_pos - player.position).normalized()

	target_position += direction_to_mouse * mouse_offset_distance

	global_position = global_position.lerp(target_position, follow_speed * delta)
	
	camera_shake(delta)

func apply_shake() -> void : 
	shake_strength = randomStrength
	
func randomOffset() -> Vector2:
	return Vector2(rng.randf_range(-shake_strength, shake_strength),rng.randf_range(-shake_strength, shake_strength))

func camera_shake(delta: float) -> void: 
	if shake_strength > 0:
		shake_strength = lerpf(shake_strength,0,shakeFade * delta)
		
		offset = randomOffset()
