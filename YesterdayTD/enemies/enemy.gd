class_name Enemy
extends Area2D


## for convenience
@export var starting_progress: float = 0.0

## this class exists exclusively for children to remember what attack spawned them
## it doesn't work if it's a component, and I didn't want to write it into every single enemy script
var progenitor_attack: Area2D

func _init() -> void:
	EnemyManager.add_enemy()
