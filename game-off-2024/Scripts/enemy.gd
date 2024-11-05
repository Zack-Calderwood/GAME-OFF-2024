extends CharacterBody2D

enum EnemyState
{
	PATROL, 
	CHASE, 	
}

var state: int = EnemyState.CHASE

var maxAttentionTimer = 5
var attentionTimer = 0
var startAttentionTimer = false

var maxAlertTimer = 1
var alertTimer = 0
var startAlertTimer = false

var randomNumber = -1 

const patrolSpeed = 50
const chaseSpeed = 120
var currentSpeed = 0

@export var player: Node2D
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D
@onready var game_manager = $"../GameManager"
var currentTarget

func _process(delta: float) -> void:
	match state :
		EnemyState.PATROL: 
			handle_patrol_state()
			alert_timer(delta)
		EnemyState.CHASE:
			chase_timer(delta)
			handle_chase_state()

func _ready() -> void:
	currentSpeed = patrolSpeed
	nav_agent.target_position = player.global_position
	currentTarget = player

func _physics_process(delta: float) -> void:
		var dir = to_local(nav_agent.get_next_path_position()).normalized()
		velocity = dir * currentSpeed
		
		
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
		startAttentionTimer = true
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
	if state == EnemyState.PATROL :
		if body == player :
			change_state()
			currentTarget = player
			attentionTimer = 0
		if body == body.get_parent() :
			print("note")
			find_new_target()
	pass # Replace with function body.
	
func change_state():
	if state == EnemyState.PATROL : 
		state = EnemyState.CHASE
		currentSpeed = chaseSpeed
	else : 
		state = EnemyState.PATROL
		currentSpeed = patrolSpeed
	print("CHANGED STATE TO: " , state)
	pass

func chase_timer(delta: float) -> void:
	if startAttentionTimer:
		attentionTimer += delta
		
		if attentionTimer >= maxAttentionTimer:
			startAttentionTimer = false
			attentionTimer = 0 
			print("LOST PLAYER")
			change_state()
			find_new_target()
	pass


func _on_touch_area_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:

	if currentTarget == area.get_parent() :
		find_new_target()
		
	if area.get_parent().name == "FlashLight" :
		print("startAlertTimer")
		startAlertTimer = true
	pass # Replace with function body.
	

func _on_touch_area_area_shape_exited(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	if area.get_parent().name == "FlashLight" :
		print("ExitAlertTimer")
		startAlertTimer = false
		alertTimer = 0
	pass # Replace with function body.

func alert_timer(delta: float) -> void:

	if startAlertTimer:
		alertTimer += delta
		if alertTimer >= maxAlertTimer:
			startAttentionTimer = false
			alertTimer = 0 
			currentTarget = player
			change_state()
	pass


func _on_touch_area_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		get_tree().reload_current_scene()
