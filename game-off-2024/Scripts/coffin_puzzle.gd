extends Node2D

var boolToggle = false 
@export var game = Node2D

func _process(delta):
	#WHen the plater presses e open up the puzzle menu
	if boolToggle:
		if Input.is_action_just_pressed("Use"):
			Dialogic.start("AdamYap")
			get_tree().change_scene_to_file("res://Scenes/churchLVL.tscn")


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		print("Playewr")
		boolToggle = true 
	pass # Replace with function body.


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player" :
		print("Playewr exit")
		boolToggle = false 
	pass # Replace with function body.
