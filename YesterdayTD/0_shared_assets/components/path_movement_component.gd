class_name PathMovementComponent
extends Node

signal reached_end

@export var path: PathFollow2D
@export var parent: Node2D
@export var speed: SpeedComponent
@export var spawn_point: Marker2D
@export var despawn_point: Area2D

var phase := 0
var spawn_position: int
var despawn_position: int


## ensure the necessary nodes are connected
func _ready() -> void:
	if not is_instance_valid(path) or not is_instance_valid(speed):
		printerr("PathMovementComponent is missing a PathComponent or a SpeedComponent!")
		return
	set_spawn_despawn_points()


## adjusts the path position to the front of the sprite
func set_spawn_despawn_points() -> void:
	if is_instance_valid(spawn_point) and is_instance_valid(despawn_point):
		spawn_position = int(spawn_point.position.x) * parent.scale.x
		despawn_position = int(despawn_point.position.x) * parent.scale.x
		path.h_offset -= spawn_position
	else:
		printerr("PathMovementComponent is missing a SpawnPoint or DespawnPoint!")
		return


## progresses the path based on the current speed
func follow_path(delta: float) -> void:
	path.set_progress(path.get_progress() + speed.current_speed * delta)
	check_phase()


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
		print("reached end!")
