extends Node

func _ready(): ## button functions
	get_node("Node/MainMenu/M/VB/NewGame").pressed.connect(on_new_game_pressed)
	get_node("Node/MainMenu/M/VB/Quit").pressed.connect(on_quit_pressed)

func on_new_game_pressed():
	get_node("Node/MainMenu").queue_free()
	var game_scene = load("res://Scenes/MainScenes/game_scene.tscn").instantiate()
	add_child(game_scene)

func on_quit_pressed():
	get_tree().quit()
