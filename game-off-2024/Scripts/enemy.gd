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
var randomNumber = 0 

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
			handle_chase_state()
	
	if startTimer:
		timer += delta

func _ready() -> void:
	nav_agent.target_position = player.global_position
	currentTarget = player.global_position

func _physics_process(delta: float) -> void:
		var dir = to_local(nav_agent.get_next_path_position()).normalized()
		velocity = dir * patrolSpeed
		
		
func makepath() -> void:
	nav_agent.target_position = currentTarget;


func _on_timer_timeout() -> void:
	makepath()
	pass # Replace with function body.
	
func handle_patrol_state():
	move_and_slide()
	pass

func handle_chase_state():
	startTimer = true
	
	currentTarget = player.global_position
	
	if timer >= timerMax:
		startTimer = false
		timer = 0 
		find_new_target()
	
	move_and_slide()
	pass
	
func find_new_target():
	state = EnemyState.PATROL
	
	var pos = game_manager.spawned_objects
	var newNum = randi_range(0,4)
	
	if newNum != randomNumber :
		currentTarget = pos[newNum].global_position
		randomNumber = newNum
	else :
		find_new_target()
	
func _on_area_2d_area_entered(area: Area2D) -> void:
	find_new_target()
	pass # Replace with function body.
