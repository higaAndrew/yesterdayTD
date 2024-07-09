extends State

var health: HealthComponent
var hitbox: CollisionShape2D

var enemy: Area2D


## get parent's components
func enter() -> void:
	hitbox = parent.hitbox
	GlobalScripts.connect_signal(parent, "area_entered", self, "_on_area_entered")
	
	health = parent.health
	GlobalScripts.connect_signal(health, "took_damage", self, "_on_took_damage")
	GlobalScripts.connect_signal(health, "health_depleted", self, "_on_health_depleted")


## handles collisions with objective
func _on_area_entered(area: Area2D) -> void:
	if not current_state():
		return
	
	# if an enemy collides, take damage and delete it (not kill it)
	## collision layer
	if area.get_collision_layer_value(5):
		enemy = area.get_parent()
		health.take_damage(enemy.damage.current_damage)
		health.play_hurt_sound()
		enemy.path_movement.delete()


## handles taking damage
func _on_took_damage(damage: float, current_health: float) -> void:
	if not current_state():
		return
	
	# after taking damage, check to see if health is zero
	print("The objective took %s damage! Its health is now %s!" % [damage, current_health])
	health.check_health_depleted()


## handles health reaching zero
func _on_health_depleted() -> void:
	if not current_state():
		return
	
	transitioned.emit(self, "ExitDie")
