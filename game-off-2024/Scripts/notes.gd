extends Sprite2D
#triggered when player walks into page 
@onready var noteSound = $"../pickup"

func _on_area_2d_body_entered(body: Node2D) -> void:
	noteSound.play()
	Events.note_Picked_Up.emit(self)
	queue_free() #delete note from game scene
	
	
	#get_parent().

	
