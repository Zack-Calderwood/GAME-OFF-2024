extends Area2D



func _process(delta):
	#WHen the plater presses e open up the puzzle menu
	if $"../..".score >= 3 :
		if Input.is_action_just_pressed("Use"):
			get_tree().change_scene_to_file("res://Scenes/churchLVL.tscn")
