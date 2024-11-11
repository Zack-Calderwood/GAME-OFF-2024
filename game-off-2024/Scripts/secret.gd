extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func flashlight_area_entered(area: Area2D) -> void:
	self.visible = true 
	pass # Replace with function body.


func flashlight_area_exited(area: Area2D) -> void:
	self.visible = false 
	pass # Replace with function body.
