extends Area2D

var boolToggle = false 


func _process(delta):
	#WHen the plater presses e open up the puzzle menu
	if $"../..".score >= 3 && boolToggle:
		if Input.is_action_just_pressed("Use"):
			get_tree().change_scene_to_file("res://Scenes/churchLVL.tscn")


func _on_body_entered(body: Node2D) -> void:
	boolToggle = true 
	pass # Replace with function body.


func _on_body_exited(body: Node2D) -> void:
	boolToggle = false 
	pass # Replace with function body.
