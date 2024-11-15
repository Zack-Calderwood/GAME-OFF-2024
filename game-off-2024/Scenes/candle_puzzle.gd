extends Node2D

var position_in_array = ""
var symbol = ""

@onready var cryptsPuzzle = $".."
@onready var symbol_text = $symbolText
@onready var note_text = $noteText

var lit = false
@onready var light = $PointLight2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	symbol_text.text = str(symbol)
	note_text.text = "Pos: " + str(position_in_array) + " sym: " + str(symbol)
	pass


func player_entered(area: Area2D) -> void:
	cryptsPuzzle.add_to_array(self)
	toggle_lit()
	pass # Replace with function body.
	
func toggle_lit()->void:
	light.visible = !light.visible
	
