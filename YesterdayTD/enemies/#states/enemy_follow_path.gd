class_name EnemyFollowPath
extends State

var health: HealthComponent
var path_movement: PathMovementComponent

var projectile: Area2D


## get parent's components
func enter() -> void:
	health = parent.health
	GlobalScripts.connect_signal(health, "health_zero", self, "_on_health_zero")
	
	path_movement = parent.path_movement
	GlobalScripts.connect_signal(path_movement, "reached_end", self, "_on_reached_end")
	
	GlobalScripts.connect_signal(parent, "area_entered", self, "_on_area_entered")


## every physics frame, call follow_path function
func physics_process(delta: float) -> void:
	path_movement.follow_path(delta)


## handle attack collisions
func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("projectiles"):
		projectile = area
		health.take_damage(projectile.damage.current_damage)
		health.play_hurt_sound()
		print("took %s damage! health is now %s!" % [projectile.damage.current_damage, health.current_health])


## handle health reaching 0
func _on_health_zero() -> void:
	transitioned.emit(self, "EnemyDie")


## handle reaching the end of the path without colliding with objective
func _on_reached_end() -> void:
	path_movement.delete()
	print("deleted!")
