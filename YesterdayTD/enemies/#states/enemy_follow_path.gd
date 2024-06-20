extends State

var progenitor_attack: Area2D
var health: HealthComponent
var path_movement: PathMovementComponent

var projectile: Area2D
var explosion: Area2D
var melee: Area2D


## get parent's components
func enter() -> void:
	progenitor_attack = parent.progenitor_attack
	GlobalScripts.connect_signal(parent, "area_entered", self, "_on_area_entered")
	
	health = parent.health
	GlobalScripts.connect_signal(health, "health_depleted", self, "_on_health_depleted")
	
	path_movement = parent.path_movement
	GlobalScripts.connect_signal(path_movement, "reached_end", self, "_on_reached_end")


## every physics frame, call follow_path function
func physics_process(delta: float) -> void:
	path_movement.follow_path(delta)


## TODO melee
## handle attack collisions
func _on_area_entered(area: Area2D) -> void:
	# if this attack spawned the enemy, ignore it
	if area == progenitor_attack:
		return
	
	# set the current attack for future comparison
	path_movement.current_attack = area
	
	if area.is_in_group("projectiles"):
		projectile = area
		
		if not projectile.pierce.pierce_expended:
			health.take_damage(projectile.damage.current_damage)
			health.play_hurt_sound()
			# tell the projectile that it has hit something
			projectile.hitbox.collide()
	
	elif area.is_in_group("explosions"):
		explosion = area
		
		if not explosion.pierce.pierce_expended:
			health.take_damage(explosion.damage.current_damage)
			health.play_hurt_sound()
			# tell the explosion that it has hit something
			explosion.hitbox.collide()
	
	elif area.is_in_group("melee_attacks"):
		pass


## handle health reaching 0
func _on_health_depleted() -> void:
	if not current_state():
		return
	
	transitioned.emit(self, "EnemyDie")


## handle reaching the end of the path without colliding with objective
## always active, enemies should never reach the end with no effect
func _on_reached_end() -> void:
	path_movement.delete()
