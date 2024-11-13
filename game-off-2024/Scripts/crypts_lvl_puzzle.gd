extends Node2D

@export var puzzle_array: Array = []
@export var puzzle_attempt_array: Array = []

var random_symbol = ["A", "B","C", "D", "E"]
var rand_index = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	puzzle_array = [$candle,$candle2,$candle3,$candle4]
	randomize_puzzle()
	init_candles()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if arrays_are_equal(puzzle_array, puzzle_attempt_array):
		print("YOU WIN")
	pass

func randomize_puzzle() -> void:
	puzzle_array.shuffle()
	
func arrays_are_equal(array1: Array, array2: Array) -> bool:
	if array1.size() != array2.size():
		return false
		
	for i in range(array1.size()):
		if array1[i] != array2[i]:
			return false  
			
	return true
	
func add_to_array(node:Node2D) -> void: 
	if !is_node_in_array(node, puzzle_attempt_array) :
		puzzle_attempt_array.append(node)
	else :
		puzzle_attempt_array.erase(node)
	
func is_node_in_array(node: Node, array: Array) -> bool:
	return node in array
	
func init_candles() -> void:
	for i in range(puzzle_array.size()):
		puzzle_array[i].position_in_array = i
		puzzle_array[i].symbol = random_index()
		random_symbol.erase(random_symbol[rand_index])
		
func random_index() -> String: 
	rand_index = randi() % random_symbol.size()
	return random_symbol[rand_index]
