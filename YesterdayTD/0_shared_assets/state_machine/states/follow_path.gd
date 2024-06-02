class_name FollowPath
extends State


## every frame, call follow_path function from pathmovement component
func physics_process(delta: float) -> void:
	parent.path_movement.follow_path(delta)
