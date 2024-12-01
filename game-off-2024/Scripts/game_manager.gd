extends Node2D



@export var spawned_objects = []

var win = "res://Scenes/winScreen.tscn"
@onready var noteSound =$"../AudioStreamPlayer"
@onready var audio_stream_player_2d: AudioStreamPlayer =$AudioStreamPlayer

#@onready var writing = $sfx_writing


func _ready() -> void:
	spawned_objects = [$"../CryptsLvl/candle",$"../CryptsLvl/candle2",$"../CryptsLvl/candle3",$"../CryptsLvl/candle4"]
	Events.note_Picked_Up.connect(remove_spawned_object)
	#Dialogic.start("adam_talking")
	#Dialogic.signal_event.connect(_on_dialogic_signal)


#func _on_dialogic_signal(argument: String):
	#if argument == "End2":
		#print("signal recived")
		#Dialogic.start("PageText")
#spawns in notes to the map
func add_spawned_object(object):
	pass
	#spawned_objects.append(object)

#removes note from the array when player picks it up
func remove_spawned_object(object):
	if audio_stream_player_2d == null:
		noteSound.play()
	if noteSound == null:
		audio_stream_player_2d.play()


#adds spawned notes to array for monster tracking
func get_spawned_objects() -> Array:
	return spawned_objects
