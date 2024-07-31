class_name LayersComponent
extends Node


@export var child_separation_distance: float = 15.0
@export var hitbox: Hitbox
@export var path_movement: PathMovementComponent

var parent: Area2D
var children: Array[PackedScene]
var number_children: Array[int]

var enemy: Area2D
var path: Path2D
var path_follow: PathFollow2D


## set children values according to stats
func init(_parent: Area2D) -> void:
	parent = _parent
	children = parent.stats.children
	number_children = parent.stats.number_children
	
	GlobalScripts.verify(parent, path_movement, "path_movement")


## handles spawning children
func spawn_children() -> void:
	if not children.is_empty() or not number_children.is_empty():
		# for every spawnable type
		for child in children.size():
			var distance: float = 0.0
			
			# spawn the number of requested children
			for child_iter in number_children[child]:
				path_follow = children[child].instantiate()
				enemy = path_follow.get_child(0)
				assign_path()
				
				enemy.progenitor_attack = hitbox.current_collision
				enemy.starting_progress = parent.path_movement.progress - distance
				distance += child_separation_distance


## sort the children to their respective layers
func assign_path() -> void:
	if enemy.is_in_group("ground_enemies"):
		path = find_parent("Canvas").find_child("GroundEnemyPath")
	elif enemy.is_in_group("ground_vehicles"):
		path = find_parent("Canvas").find_child("GroundVehiclePath")
	elif enemy.is_in_group("ground_bosses"):
		path = find_parent("Canvas").find_child("GroundBossPath")
	elif enemy.is_in_group("flying_enemies"):
		path = find_parent("Canvas").find_child("FlyingEnemyPath")
	elif enemy.is_in_group("flying_vehicles"):
		path = find_parent("Canvas").find_child("FlyingVehiclePath")
	elif enemy.is_in_group("flying_bosses"):
		path = find_parent("Canvas").find_child("FlyingBossPath")
	else:
		printerr("The child %s is not in an enemy group!" % enemy.name)
		return
	
	path.call_deferred("add_child", path_follow)
