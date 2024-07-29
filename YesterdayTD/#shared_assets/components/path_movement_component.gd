class_name PathMovementComponent
extends Node


signal reached_end

@export var spawn_point: Marker2D
@export var despawn_point: Area2D
@export var path_follow: PathFollow2D
@export var speed: SpeedComponent

var parent: Area2D
var starting_progress: float
var spawn_position: float
var despawn_position: float
var phase: int = 0
var progress: float


## ensure the necessary nodes are connected
func init(_parent: Area2D) -> void:
	parent = _parent
	starting_progress = parent.starting_progress
	
	GlobalScripts.verify(parent, spawn_point, "spawn_point")
	GlobalScripts.verify(parent, despawn_point, "despawn_point")
	GlobalScripts.verify(parent, path_follow, "path_follow")
	GlobalScripts.verify(parent, speed, "speed")
	
	set_spawn_despawn_points()
	path_follow.set_progress(starting_progress)


## adjusts the path position towards the front of the sprite
func set_spawn_despawn_points() -> void:
	# if spawn/despawn point exists, set them, scale adjusted
	if is_instance_valid(spawn_point) and is_instance_valid(despawn_point):
		spawn_position = spawn_point.position.x * parent.scale.x
		despawn_position = despawn_point.position.x * parent.scale.x
		
		# if the spawn is at the beginning of the path
		if starting_progress == 0.0:
			path_follow.h_offset -= spawn_position
		# if the spawn happens in the middle of the path, skip the beginning phase
		else:
			phase = 1
	
	else:
		printerr("PathMovementComponent is missing a SpawnPoint(Marker2D) or DespawnPoint(Area2D)!")
		return


## progresses the path based on the current speed
func follow_path(delta: float) -> void:
	path_follow.set_progress(path_follow.get_progress() + speed.current_speed * delta)
	progress = path_follow.get_progress()
	check_phase()


## reverses the path based on the current speed
func reverse_path(delta: float) -> void:
	path_follow.set_progress(path_follow.get_progress() - speed.current_speed * delta)
	progress = path_follow.get_progress()


## adjusts the parent's path position so that the path begins at the front of the sprite and ends at the back of it
func check_phase() -> void:
	# adjusts path position to the center of the sprite
	if path_follow.get_progress() >= starting_progress + spawn_position and phase == 0:
		phase = 1
		path_follow.h_offset = 0.0
		path_follow.set_progress(starting_progress)
	
	# adjusts path position to the back of the sprite
	elif path_follow.get_progress_ratio() >= 1 and phase == 1:
		phase = 2
		path_follow.h_offset -= despawn_position
		path_follow.set_progress(path_follow.get_progress() + despawn_position)
	
	# checks to see if path is complete
	elif path_follow.get_progress_ratio() >= 1 and phase == 2:
		phase = 3
		reached_end.emit()


## delete the path, and by extension, the object travelling it
func delete() -> void:
	EnemyManager.remove_enemy()
	path_follow.queue_free()


## set the object's path progress manually
func set_progress(_progress: float) -> void:
	path_follow.set_progress(_progress)
	progress = path_follow.get_progress()
