extends Label

@onready var writing = $sfx_writing
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.score_update.connect(update_text)


func update_text(score):
	#fade in from 0-1 quickly
	#fade out from 1-0 slowly
	writing.play()
	self.text = "you have " + str(score) +  "/6 pages."
	$AnimationPlayer.play("text_animation")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
