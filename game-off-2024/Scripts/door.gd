extends Node2D


var max_x_position = 200  # Change to your desired max position
var min_x_position = 100  # Change to your desired min position

func _integrate_forces(state):
	# Keep door position within range on x-axis
	if position.x > max_x_position:
		position.x = max_x_position
	elif position.x < min_x_position:
		position.x = min_x_position
