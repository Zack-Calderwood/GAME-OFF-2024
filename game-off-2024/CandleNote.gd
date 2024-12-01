extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		$Sprite2D2.visible = true
	pass # Replace with function body.
	
func add_text(text: String) -> void: 
	$Sprite2D2/Label.text = text
	pass 


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		$Sprite2D2.visible = false
	
	pass # Replace with function body.
