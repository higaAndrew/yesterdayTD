class_name PathMovement
extends Node

signal reached_end

@export var path: PathFollow2D
@export var speed: Speed


## ensure the necessary nodes are connected
func _ready() -> void:
	if not is_instance_valid(path) or not is_instance_valid(speed):
		printerr("PathMovement component is missing one or more exported values.")


## progresses the path based on the current speed
func follow_path(delta: float) -> void:
	path.set_progress(path.get_progress() + speed.current_speed * delta)
	if path.get_progress_ratio() >= 1:
		push_error("Enemy has reached the end of the path with no reaction.")
