extends CharacterBody2D

const PUSH_FORCE = 15.0
const MIN_PUSH_FORCE = 10.0

var speed = 75
var collision

@export var enemy: Node2D
@onready var light = $FlashLight
@onready var flashlightGhost = $GhostFlashLight
@onready var progressBar = $ProgressBar
@onready var walkingSFX = $sfx_walking
@onready var switchSFX = $sfx_switch

var flashON = false


func _process(delta):
	
#	if Input.is_action_pressed("Inv")
		#when tab is pressed open and close the inventory
		
	
	if progressBar.value == 0:
		light.visible = false
		flashlightGhost.visible = false	
		
#if the left mouse is pressed turn on the flashlight
	if Input.is_action_just_pressed("Toggle") and progressBar.value > 0:
		
		flashON = !flashON
		toggle_Flash_Light(light)
		flashlightGhost.visible = false
		
		
#if the right mouse is pressed turn on the flashlight		

	if Input.is_action_just_pressed("Toggle2") and progressBar.value > 0:
	
		flashON = !flashON
		toggle_Flash_Light(flashlightGhost)
		light.visible = false 
	#player movement controlls
	var direction = Vector2.ZERO
	if Input.is_action_pressed("ui_right"):
		direction.x += 1
		
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
		
	if Input.is_action_pressed("ui_down"):
		direction.y += 1
		
	if Input.is_action_pressed("ui_up"):
		direction.y -= 1
		
	
		#when the light is turned on drain the battery 
	if light.visible == true or flashlightGhost.visible == true: 
		progressBar.value -= 1
		#when the light is turned off recharge the battery 
	elif light.visible == false and flashlightGhost.visible == false :
		progressBar.value += 1.5
		

	if direction != Vector2.ZERO:
		direction = direction.normalized() * speed


	velocity = direction  

	
	move_and_slide()
	door_push()
	
func toggle_Flash_Light(Light):
		switchSFX.play()
		Light.visible = !Light.visible #change this back to Light.visible = flashON
		

func door_push():
	for i in get_slide_collision_count():
		var c = get_slide_collision(i)
		if c.get_collider() is RigidBody2D:
			var push_force = (PUSH_FORCE*velocity.length()/speed ) + MIN_PUSH_FORCE
			c.get_collider().apply_central_impulse(-c.get_normal() * push_force)
			
