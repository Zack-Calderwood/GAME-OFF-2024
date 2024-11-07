extends CharacterBody2D

enum EnemyState
{
	PATROL, 
	CHASE, 	
	SEARCH,
}

var state: int = EnemyState.CHASE

const PUSH_FORCE = 15.0
const MIN_PUSH_FORCE = 10.0


var randomNumber = -1 

const patrolSpeed = 50
const chaseSpeed = 120
var currentSpeed = 0

@export var player: Node2D
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D
@onready var game_manager = $"../GameManager"

var currentTarget
var angle_to_target
var randomTarget 
var seesPlayer = false 

@export var cone_angle = 45
@export var ray_count = 10
@export var max_distance = 45

var detected_enemies = []
@onready var timer = $Timer
@onready var timerState = $Timer2

func _process(delta: float) -> void:
	door_push()
	match state :
		EnemyState.PATROL: 
			handle_patrol_state()
			vision_cone_detect(delta,1)
			timer.stop()
		EnemyState.CHASE:
			handle_chase_state()
			vision_cone_detect(delta,10)
		EnemyState.SEARCH:
			handle_search_state()
			vision_cone_detect(delta,1)

func _ready() -> void:
	currentSpeed = patrolSpeed
	nav_agent.target_position = player.global_position
	currentTarget = player
	create_vision_cone()

func _physics_process(delta: float) -> void:
		var dir = to_local(nav_agent.get_next_path_position()).normalized()
		velocity = dir * currentSpeed
		makepath()
		
func makepath() -> void:
	nav_agent.target_position = currentTarget.global_position;

func _on_timer_timeout() -> void:
	print("Timer end")
	find_new_target()
	pass # Replace with function body.
	
func handle_patrol_state():
	move_and_slide()
	pass

func handle_chase_state():
	if state == EnemyState.CHASE :
		currentTarget = player
		move_and_slide()
	pass

func handle_search_state():	
	currentSpeed = 1
	
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
			timer.start()
			
			
	pass # Replace with function body.
	
func change_state(newState: int):
	state = newState
	currentSpeed = 50
	print("current state " , state)
	find_new_target()
	pass

func _on_touch_area_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	if currentTarget == area.get_parent() :
		find_new_target()
	
	pass # Replace with function body.
	
func _on_touch_area_area_shape_exited(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	pass # Replace with function body.

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
	
	for i in range(ray_count):
		angle_to_target = global_position.angle_to_point(currentTarget.position)
		var angle = deg_to_rad(-cone_angle / 2 + cone_angle * i / (ray_count - 1))
		var direction = Vector2(cos(angle_to_target), sin(angle_to_target))
		var ray = get_child(i + 8)  # this need to be revisted can't have 6 here 
		
		ray.target_position = ray.target_position.lerp(direction * max_distance, delta * look_speed)
		ray.rotation = angle 
		
		if ray.is_colliding():
			var collider = ray.get_collider()
			if state != EnemyState.CHASE : 
				if collider == player:
					seesPlayer = true
					currentTarget = player
					change_state(EnemyState.CHASE)
					
	var lightPos = currentTarget.position

	var dire = lightPos - global_position

	$FlashLight.rotation = lerp_angle($FlashLight.rotation, dire.angle(), look_speed * delta)

	pass

func _on_player_exit_body_exited(body: Node2D) -> void:
	if state == EnemyState.SEARCH :
		if body == player :
			timerState.start()
			print("timer start")
	pass # Replace with function body.

func _on_change_state_timeout() -> void:
	print("Timer ended now patrol")
	change_state(EnemyState.PATROL)
	pass # Replace with function body.
	
func door_push():
	for i in get_slide_collision_count():
		var c = get_slide_collision(i)
		if c.get_collider() is RigidBody2D:
			var push_force = (PUSH_FORCE*velocity.length()/currentSpeed ) + MIN_PUSH_FORCE
			c.get_collider().apply_central_impulse(-c.get_normal() * push_force)
