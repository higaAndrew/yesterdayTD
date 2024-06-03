class_name FollowPath
extends State

var path_movement = PathMovementComponent
var health = HealthComponent


## make reference to parent's components
func enter() -> void:
	path_movement = parent.path_movement
	health = parent.health

	if not is_instance_valid(path_movement) or not is_instance_valid(health):
		printerr("FollowPath's parent is missing one or more components!")
		return

	GlobalScripts.connect_signal(parent, "area_entered", self, "_on_area_entered")


## every physics frame, call follow_path function
func physics_process(delta: float) -> void:
	path_movement.follow_path(delta)


## TODO handle projectile collisions
func _on_area_entered(area: Area2D) -> void:
	print("hi")
