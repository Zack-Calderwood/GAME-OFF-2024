extends CharacterBody2D

# Movement speed (pixels per second)
var speed = 200

# Called every frame
func _process(delta):
	# Get input direction
	var direction = Vector2.ZERO
	if Input.is_action_pressed("ui_right"):
		direction.x += 1
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_down"):
		direction.y += 1
	if Input.is_action_pressed("ui_up"):
		direction.y -= 1

	# Normalize direction to prevent faster diagonal movement, then apply speed
	if direction != Vector2.ZERO:
		direction = direction.normalized() * speed

	# Use move_and_slide to handle movement and collisions
	velocity = direction  # Set velocity based on direction and speed
	move_and_slide()
