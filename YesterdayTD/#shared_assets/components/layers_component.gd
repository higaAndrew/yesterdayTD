class_name LayersComponent
extends Node

@export var child_distance_value := 15.0

var parent: Area2D
var children: Array[PackedScene]
var number_children: Array[int]

var creator
var enemy_path: PathFollow2D
var enemy: Area2D
var path_movement: PathMovementComponent
var layer: Path2D
var multi_child_distance: float


## set children values according to stats
func init(_parent: Area2D) -> void:
	parent = _parent
	children = parent.stats.children
	number_children = parent.stats.number_children


## handles spawning children
func spawn_children() -> void:
	if not children.is_empty() or not number_children.is_empty():
		# for every spawnable type
		for child in children.size():
			multi_child_distance = 0.0
			# spawn the number of requested children
			for child_iter in number_children[child]:
				enemy_path = children[child].instantiate()
				enemy = enemy_path.get_child(0)
				assign_path()
				enemy.starting_progress = parent.path_movement.progress - multi_child_distance
				enemy.progenitor_attack = parent.path_movement.current_attack
				multi_child_distance += child_distance_value


## sort the children to their respective layers
func assign_path() -> void:
	if enemy.is_in_group("ground_enemies"):
		layer = find_parent("Canvas").find_child("GroundEnemyPath")
	elif enemy.is_in_group("ground_vehicles"):
		layer = find_parent("Canvas").find_child("GroundVehiclePath")
	elif enemy.is_in_group("ground_bosses"):
		layer = find_parent("Canvas").find_child("GroundBossPath")
	elif enemy.is_in_group("air_enemies"):
		layer = find_parent("Canvas").find_child("AirEnemyPath")
	elif enemy.is_in_group("air_vehicles"):
		layer = find_parent("Canvas").find_child("AirVehiclePath")
	elif enemy.is_in_group("air_bosses"):
		layer = find_parent("Canvas").find_child("AirBossPath")
	else:
		printerr("The child %s is not in an enemy group!" % enemy.name)
		return
	layer.call_deferred("add_child", enemy_path)
