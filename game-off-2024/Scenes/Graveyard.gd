extends Node2D

@export var label = Node2D
var score = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Dialogic.start("adam_talking")
	Dialogic.signal_event.connect(_on_dialogic_signal)
	

func _on_dialogic_signal(argument: String):
	if argument == "End2":
		print("signal recived")
		Dialogic.start("PageText")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	label.text = str(score) + "/3 NOTES"
	pass
