extends Node2D
#triggered when player walks into page 
@onready var noteSound = $pickup
@export var gameScene = Node2D
#@export var item: InvItem
#var player = null

func _on_area_2d_body_entered(body: Node2D) -> void:
#	player.pickup(item)
	noteSound.play()
	Events.note_Picked_Up.emit(self)
	queue_free() #delete note from game scene
	gameScene.score += 1 
	
	#get_parent().
	

	
