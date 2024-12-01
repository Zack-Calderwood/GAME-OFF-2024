extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	Dialogic.signal_event.connect(_on_dialogic_signal)
	Dialogic.start("timeline")

func _on_dialogic_signal(argument: String):
	if argument == "End":
		print("signal recived")
		get_tree().change_scene_to_file("res://Scenes/game.tscn")
