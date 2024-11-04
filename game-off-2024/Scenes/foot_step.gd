extends Sprite2D

var timer_Max = 10
var timer = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	
	timer += delta
	
	var alpha = clamp(1.0 - (timer / timer_Max), 0.0, 1.0)
	
	modulate.a = alpha
	
	"if fade_timer >= fade_duration:"
		
	
	pass
