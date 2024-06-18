class_name LayersComponent
extends Node

var parent: Area2D
var children: Array[PackedScene]
var number_children: Array[int]

var creator
var enemy: PathFollow2D
var path_movement: PathMovementComponent
var layer: Path2D


## set children values according to stats
func init(_parent: Area2D) -> void:
	parent = _parent
	children = parent.stats.children
	number_children = parent.stats.number_children


func spawn_children() -> void:
	if not children.is_empty() or not number_children.is_empty():
		for child in children.size():
			enemy = children[child].instantiate()
			assign_path(enemy)
			enemy.get_child(0).starting_progress = parent.path_movement.progress


func assign_path(_enemy: PathFollow2D) -> void:
	if _enemy.is_in_group("ground_enemies"):
		layer = find_parent("Canvas").find_child("GroundEnemyPath")
	elif _enemy.is_in_group("ground_vehicles"):
		layer = find_parent("Canvas").find_child("GroundVehiclePath")
	elif _enemy.is_in_group("ground_bosses"):
		layer = find_parent("Canvas").find_child("GroundBossPath")
	elif _enemy.is_in_group("air_enemies"):
		layer = find_parent("Canvas").find_child("AirEnemyPath")
	elif _enemy.is_in_group("air_vehicles"):
		layer = find_parent("Canvas").find_child("AirVehiclePath")
	elif _enemy.is_in_group("air_bosses"):
		layer = find_parent("Canvas").find_child("AirBossPath")
	else:
		printerr("%s is not in an enemy group!" % _enemy.name)
	layer.call_deferred("add_child", _enemy)