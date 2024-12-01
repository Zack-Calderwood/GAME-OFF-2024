extends Node2D
@export var rain_img = Sprite2D
@export var rain_img2 = Sprite2D

var speed = 600
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rain_img.position += Vector2(0, speed * delta)
	rain_img2.position += Vector2(0, speed * delta)
	move_rain()
	pass

func move_rain() -> void: 
	if rain_img.position.y >= 200:
		rain_img.position = Vector2(0,-800)
	if rain_img2.position.y >= 200:
		rain_img2.position = Vector2(0,-800)
	pass
