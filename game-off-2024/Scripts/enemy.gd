extends CharacterBody2D

enum EnemyState
{
	PATROL, 
	CHASE, 	
	SEARCH,
}

var state: int = EnemyState.SEARCH

const PUSH_FORCE = 15.0
const MIN_PUSH_FORCE = 10.0


var randomNumber = -1 

const patrolSpeed = 50
const chaseSpeed = 120
var currentSpeed = 0

var currentTarget
var angle_to_target

var seesPlayer = false 


@export var last_location: Node2D
@export var player: Node2D
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D
@onready var game_manager = $"../GameManager"

@export var cone_angle = 45
@export var ray_count = 10
@export var max_distance = 45

@onready var timer = $Timer
@onready var timerState = $Timer2

func _process(delta: float) -> void:
	door_push()
	match state :
		EnemyState.PATROL: 
			handle_patrol_state(delta)
		EnemyState.CHASE:
			handle_chase_state(delta)
		EnemyState.SEARCH:
			handle_search_state(delta)

func _ready() -> void:
	currentSpeed = patrolSpeed
	nav_agent.target_position = player.global_position
	currentTarget = player
	create_vision_cone()
	Events.enemy_alert.connect(enemy_check_location)

func _physics_process(delta: float) -> void:
	var dir = to_local(nav_agent.get_next_path_position()).normalized()
	velocity = dir * currentSpeed
	makepath()
		
func makepath() -> void:
	nav_agent.target_position = currentTarget.global_position;

func handle_patrol_state(delta: float):
	enemy_at_location()
	vision_cone_detect(delta,1)
	move_and_slide()
	pass

func handle_chase_state(delta: float):
	enemy_at_location()
	vision_cone_detect(delta,10)
	move_and_slide()
	pass

func handle_search_state(delta: float):	
	vision_cone_detect(delta,2)
	pass
	
func find_new_target():
	print("find new target")
	var pos = game_manager.spawned_objects
	var newNum = randi_range(0,4)
	
	if newNum != randomNumber :
		currentTarget = pos[newNum]
		randomNumber = newNum
	else :
		find_new_target()
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if state == EnemyState.PATROL :
		if body == player :
			change_state(EnemyState.SEARCH)
			currentTarget = player
			timerState.start()
			print("body entered")
			
			
	pass # Replace with function body.
	
func change_state(newState: EnemyState):
	state = newState
	currentSpeed = 50
	print("Changing state to: " , state)
	pass

func _on_touch_area_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		get_tree().reload_current_scene()
		
func create_vision_cone() -> void:
	for i in range(ray_count):
		var ray = RayCast2D.new()
		ray.enabled = true
		ray.collision_mask = 3
		add_child(ray)
	pass 

func vision_cone_detect(delta: float, look_speed: float) -> void:
	
	var detected = false 
	
	for i in range(ray_count):
		angle_to_target = global_position.angle_to_point(currentTarget.position)
		var angle = deg_to_rad(-cone_angle / 2 + cone_angle * i / (ray_count - 1))
		var direction = Vector2(cos(angle_to_target), sin(angle_to_target))
		var ray = get_child(i + 9)  # this need to be revisted can't have 6 here 
		ray.target_position = ray.target_position.lerp(direction * max_distance, delta * look_speed)
		ray.rotation = lerp_angle(ray.rotation, angle, look_speed * delta)
		
		if ray.is_colliding():
			var collider = ray.get_collider()
			if collider == player:
				detected = true 
				if !seesPlayer:
					seesPlayer = true
					$LOS_Timer.stop()
					currentTarget = player
					print("Player detected!")
					if(state != EnemyState.CHASE) :
						change_state(EnemyState.CHASE)
					break
	if !detected and seesPlayer:
		detected = false
		$LOS_Timer.start()
		print("Lost line of eight")
		seesPlayer = false 

	
	var lightPos = currentTarget.position

	var dire = lightPos - global_position

	$FlashLight.rotation = lerp_angle($FlashLight.rotation, dire.angle(), look_speed * delta)

	pass

func _on_change_state_timeout() -> void:
	print("End searching for player")
	find_new_target()
	change_state(EnemyState.PATROL)
	pass # Replace with function body.
	
func door_push():
	for i in get_slide_collision_count():
		var c = get_slide_collision(i)
		if c.get_collider() is RigidBody2D:
			var push_force = (PUSH_FORCE*velocity.length()/currentSpeed ) + MIN_PUSH_FORCE
			c.get_collider().apply_central_impulse(-c.get_normal() * push_force)

func enemy_check_location(gameObject: Node2D) -> void:
	if state != EnemyState.CHASE :
		change_state(EnemyState.CHASE)
		currentTarget = gameObject
		print("current target : ", currentTarget , "In state: ", state)
	pass
	
func enemy_at_location() -> void: 
	var offsetLocation = 2
	if position.distance_to(currentTarget.position) <= offsetLocation:
		print("at location")
		change_state(EnemyState.SEARCH)
		call_with_delay("find_new_target", 1.0, 5)	
	pass

func los_timer_timeout() -> void:
	last_location.global_position = currentTarget.global_position
	currentTarget = last_location
	pass # Replace with function body.
	
func call_with_delay(func_name: String, delay: float, times: int) -> void:
	$Timer.wait_time = delay
	for i in range(times):
		$Timer.start()
		await $Timer.timeout
		call(func_name)
	change_state(EnemyState.PATROL)
