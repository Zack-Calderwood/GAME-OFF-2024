extends Node2D



@export var spawned_objects = []
var score = 0
var win = "res://Scenes/winScreen.tscn"
@onready var noteSound = $"../AudioStreamPlayer"
@onready var writing = $sfx_writing


func _ready() -> void:
	spawned_objects = [$"../CryptsLvl/candle",$"../CryptsLvl/candle2",$"../CryptsLvl/candle3",$"../CryptsLvl/candle4"]
	Events.note_Picked_Up.connect(remove_spawned_object)
	
#spawns in notes to the map
func add_spawned_object(object):
	pass
	#spawned_objects.append(object)

#removes note from the array when player picks it up
func remove_spawned_object(object):
	noteSound.play()
	#writing.play()
	score += 1
	Events.score_update.emit(score)
	print("you have" , score , " notes")
	spawned_objects.remove_at(spawned_objects.find(object))
	
	if score == 6:
		print("winscreen")
		get_tree().change_scene_to_file("res://Scenes/winScreen.tscn")
		#Events.player_win.emit() #fancy matt way
		
		
#adds spawned notes to array for monster tracking
func get_spawned_objects() -> Array:
	return spawned_objects
	
