extends Sprite2D
#triggered when player walks into page 


func _on_area_2d_body_entered(body: Node2D) -> void:
	print("+1 note") #debug print gained one note
	Events.note_Picked_Up.emit(self)
	queue_free() #delete note from game scene
	

	
