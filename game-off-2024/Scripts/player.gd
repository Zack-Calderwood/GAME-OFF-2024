extends CharacterBody2D

const PUSH_FORCE = 15.0
const MIN_PUSH_FORCE = 10.0

var speed = 150
var collision

@export var enemy: Node2D



func _process(delta):

	var direction = Vector2.ZERO
	if Input.is_action_pressed("ui_right"):
		direction.x += 1
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_down"):
		direction.y += 1
	if Input.is_action_pressed("ui_up"):
		direction.y -= 1
	
	if Input.is_action_just_pressed("F"):
		$FlashLight.visible = !$FlashLight.visible
		$GhostFlashLight.visible = !$GhostFlashLight.visible
		print("imworking")
	
		

	if direction != Vector2.ZERO:
		direction = direction.normalized() * speed


	velocity = direction  

	
	move_and_slide()
	
	for i in get_slide_collision_count():
		var c = get_slide_collision(i)
		if c.get_collider() is RigidBody2D:
			var push_force = (PUSH_FORCE*velocity.length()/speed ) + MIN_PUSH_FORCE
			c.get_collider().apply_central_impulse(-c.get_normal() * push_force)
			
