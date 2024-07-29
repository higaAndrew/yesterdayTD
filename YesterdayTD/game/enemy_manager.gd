extends Node
## this autoload script holds all of the enemy functions for the current map


signal wave_completed

var remaining_enemies: int
var spawns_finished: bool = false


## append enemy to array of remaining enemies
func add_enemy() -> void:
	remaining_enemies += 1


## erase enemy from array of remaining enemies
## start the next wave if there are no more enemies
func remove_enemy() -> void:
	remaining_enemies -= 1
	
	print(remaining_enemies)
	
	if spawns_finished:
		if remaining_enemies == 0:
			wave_completed.emit()
			spawns_finished = false
			print("hell yeah")


## acknowledge when the last enemy has spawned
func on_wave_spawns_finished() -> void:
	spawns_finished = true
