extends Node2D
@export var game = Node2D

var boolToggle = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if game.score >= 3 && boolToggle:
		if Input.is_action_just_pressed("Use"):
			get_tree().change_scene_to_file("res://Scenes/cryptsLVL.tscn")
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	print("Player")
	boolToggle = true
	pass # Replace with function body.


func _on_area_2d_body_exited(body: Node2D) -> void:
	boolToggle = false
	pass # Replace with function body.
