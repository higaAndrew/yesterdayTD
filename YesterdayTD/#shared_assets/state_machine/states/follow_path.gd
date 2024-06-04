class_name FollowPath
extends State

var path_movement = PathMovementComponent
var health = HealthComponent


## make reference to parent's components
func enter() -> void:
	path_movement = parent.path_movement
	health = parent.health

	GlobalScripts.verify(parent, path_movement, "path_movement")
	GlobalScripts.verify(parent, health, "health")

	GlobalScripts.connect_signal(parent, "area_entered", self, "_on_area_entered")
	GlobalScripts.connect_signal(path_movement, "reached_end", self, "_on_reached_end")


## every physics frame, call follow_path function
func physics_process(delta: float) -> void:
	path_movement.follow_path(delta)


## TODO handle projectile collisions
func _on_area_entered(area: Area2D) -> void:
	print("hi")


## handle reaching the end of the path without colliding with objective
func _on_reached_end() -> void:
	path_movement.delete()
	print("deleted!")
