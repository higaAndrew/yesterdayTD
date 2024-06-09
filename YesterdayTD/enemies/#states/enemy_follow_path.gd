class_name EnemyFollowPath
extends State

var path_movement: PathMovementComponent
var health: HealthComponent

var projectile: Area2D

## TODO spawn sound
## get parent's components
func enter() -> void:
	path_movement = parent.path_movement
	health = parent.health

	GlobalScripts.verify(parent, path_movement, "path_movement")
	GlobalScripts.verify(parent, health, "health")

	GlobalScripts.connect_signal(parent, "area_entered", self, "_on_area_entered")
	GlobalScripts.connect_signal(path_movement, "reached_end", self, "_on_reached_end")
	GlobalScripts.connect_signal(health, "health_zero", self, "_on_health_zero")


## every physics frame, call follow_path function
func physics_process(delta: float) -> void:
	path_movement.follow_path(delta)


## TODO handle projectile collisions
func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("projectiles"):
		projectile = area
		health.take_damage(projectile.damage.current_damage)
		print("took %s damage! health is now %s!" %[projectile.damage.current_damage, health.current_health])


## handle reaching the end of the path without colliding with objective
func _on_reached_end() -> void:
	path_movement.delete()
	print("deleted!")


func _on_health_zero() -> void:
	transitioned.emit(self, "EnemyDie")
