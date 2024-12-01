extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Dialogic.start("adam_talking")
	Dialogic.signal_event.connect(_on_dialogic_signal)


func _on_dialogic_signal(argument: String):
	if argument == "End2":
		print("signal recived")
		Dialogic.start("PageText")
