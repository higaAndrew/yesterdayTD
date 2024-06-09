class_name ObjectiveIdle
extends State

var health: HealthComponent
var hitbox: CollisionShape2D

var enemy: Area2D


## get parent's components
func enter() -> void:
	health = parent.health
	hitbox = parent.hitbox
	
	GlobalScripts.verify(parent, health, "health")
	GlobalScripts.verify(parent, hitbox, "hitbox")

	GlobalScripts.connect_signal(parent, "area_entered", self, "_on_area_entered")
	GlobalScripts.connect_signal(health, "took_damage", self, "_on_took_damage")
	GlobalScripts.connect_signal(health, "health_zero", self, "_on_health_zero")


## handles collisions with objective
func _on_area_entered(area: Area2D) -> void:
	if not current_state():
		return
	
	# if an enemy collides, take damage and delete it
	if area.is_in_group("enemies") and area.is_in_group("despawn_points"):
		enemy = area.get_parent()
		health.take_damage(enemy.damage.current_damage)
		enemy.queue_free()


## handles taking damage
func _on_took_damage(damage: float, current_health: float) -> void:
	if not current_state():
		return
	
	# after taking damage, check to see if health is zero
	print("The objective took %s damage! Its health is now %s!" %[damage, current_health])
	
	# might want to remove this to make the code more modular
	health.check_health_zero()


## handles health reaching zero
func _on_health_zero() -> void:
	if not current_state():
		return
	
	# transition to die state
	transitioned.emit(self, "Die")
	print(parent.health.current_health)



