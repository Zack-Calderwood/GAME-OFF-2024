extends CharacterBody2D

enum EnemyState
{
	PATROL, 
	CHASE, 	
}

var state: int = EnemyState.PATROL



var patrolSpeed = 50
var chaseSpeed = 80

const speed = 50 

@export var player: Node2D
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D

func _process(delta: float) -> void:
	print("State: ", state)
	match state :
		EnemyState.PATROL: 
			handle_patrol_state()
		EnemyState.CHASE:
			handle_chase_state()
	



func _physics_process(delta: float) -> void:
		var dir = to_local(nav_agent.get_next_path_position()).normalized()
		velocity = dir * speed
		
		
func makepath() -> void:
	nav_agent.target_position = player.global_position


func _on_timer_timeout() -> void:
	makepath()
	pass # Replace with function body.
	
func handle_patrol_state():
	
	pass


func handle_chase_state():
	move_and_slide()
	pass
	
