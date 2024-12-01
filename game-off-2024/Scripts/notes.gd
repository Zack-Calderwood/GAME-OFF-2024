extends Node2D
#triggered when player walks into page 
@onready var noteSound = $pickup
@onready var pickup = $AudioStreamPlayer
@export var gameScene = Node2D
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

#@export var item: InvItem
#var player = null

func _on_area_2d_body_entered(body: Node2D):
	#pickup.play()
	audio_stream_player.play()
	Events.note_Picked_Up.emit(self)
	queue_free() #delete note from game scene
	gameScene.score += 1 
	

	

	
