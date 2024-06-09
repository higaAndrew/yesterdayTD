class_name PathMovementComponent
extends Node

signal reached_end

@export var spawn_point: Marker2D
@export var despawn_point: Area2D
@export var path: PathFollow2D
@export var speed: SpeedComponent

var parent: Node2D
var phase := 0
var spawn_position: float
var despawn_position: float
var progress: float


## ensure the necessary nodes are connected
func init(_parent: Node2D) -> void:
	parent = _parent
	
	GlobalScripts.verify(self, spawn_point, "spawn_point")
	GlobalScripts.verify(self, despawn_point, "despawn_point")
	GlobalScripts.verify(self, path, "path")
	GlobalScripts.verify(self, speed, "speed")
	
	set_spawn_despawn_points()


## adjusts the path position towards the front of the sprite
func set_spawn_despawn_points() -> void:
	if is_instance_valid(spawn_point) and is_instance_valid(despawn_point):
		spawn_position = spawn_point.position.x * parent.scale.x
		despawn_position = despawn_point.position.x * parent.scale.x
		path.h_offset -= spawn_position
	else:
		printerr("PathMovementComponent is missing a SpawnPoint(Marker2D) or DespawnPoint(Area2D)!")
		return


## progresses the path based on the current speed
func follow_path(delta: float) -> void:
	path.set_progress(path.get_progress() + speed.current_speed * delta)
	progress = path.get_progress()
	check_phase()


## reverses the path based on the current speed
func reverse_path(delta: float) -> void:
	path.set_progress(path.get_progress() - speed.current_speed * delta)
	progress = path.get_progress()


## adjusts the parent's path position so that the path begins at the front of the sprite and ends at the back of it
func check_phase() -> void:
	# adjusts path position to the center of the sprite
	if path.get_progress() >= spawn_position and phase == 0:
		phase = 1
		path.h_offset = 0
		path.set_progress(0)
	# adjusts path position to the back of the sprite
	elif path.get_progress_ratio() >= 0.999 and phase == 1:
		phase = 2
		path.h_offset -= despawn_position
		path.set_progress(path.get_progress() + despawn_position)
	# checks to see if path is complete
	elif path.get_progress_ratio() >= 1 and phase == 2:
		phase = 3
		reached_end.emit()


## delete the path, and by extension, the object travelling it
func delete() -> void:
	path.queue_free()
