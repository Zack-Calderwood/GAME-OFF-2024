extends CharacterBody2D

enum EnemyState
{
	PATROL, 
	CHASE, 	
}

var state: int = EnemyState.CHASE

var timerMax = 2
var timer = 0
var startTimer = false
var randomNumber = -1 

var patrolSpeed = 50
var chaseSpeed = 80


@export var player: Node2D
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D
@onready var game_manager = $"../GameManager"
var currentTarget

func _process(delta: float) -> void:
	match state :
		EnemyState.PATROL: 
			handle_patrol_state()
		EnemyState.CHASE:
			chase_timer(delta)
			handle_chase_state()

func _ready() -> void:
	nav_agent.target_position = player.global_position
	currentTarget = player

func _physics_process(delta: float) -> void:
		var dir = to_local(nav_agent.get_next_path_position()).normalized()
		velocity = dir * patrolSpeed
		
		
func makepath() -> void:
	nav_agent.target_position = currentTarget.global_position;

func _on_timer_timeout() -> void:
	makepath()
	pass # Replace with function body.
	
func handle_patrol_state():
	move_and_slide()
	pass

func handle_chase_state():
	if state == EnemyState.CHASE :
		startTimer = true
		print("Chasing")
		currentTarget = player
		move_and_slide()
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
	if body == player :
		change_state()
		currentTarget = player
	if body == body.get_parent() :
		print("note")
		find_new_target()
	pass # Replace with function body.
	
func change_state():
	if state == EnemyState.PATROL : 
		state = EnemyState.CHASE
	else : 
		state = EnemyState.PATROL
	print("CHANGED STATE TO: " , state)
	pass

func chase_timer(delta: float) -> void:
	if startTimer:
		timer += delta
		
		if timer >= timerMax:
			startTimer = false
			timer = 0 
			print("LOST PLAYER")
			change_state()
			find_new_target()
	pass


func _on_touch_area_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	if currentTarget == area.get_parent() :
		find_new_target()
	
	pass # Replace with function body.
