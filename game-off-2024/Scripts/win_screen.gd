extends Control


func _on_play_again_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/game.tscn")



func _on_return_to_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/mainMenu.tscn")
