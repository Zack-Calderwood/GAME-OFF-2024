extends Node2D

var boolToggle = false 

@onready var trig: CollisionShape2D = $Area2D/trig





	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		Dialogic.start("church")
		print("here")
		trig.disabled
