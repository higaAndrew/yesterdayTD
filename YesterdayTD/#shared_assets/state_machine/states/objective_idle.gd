class_name ObjectiveIdle
extends State

var health: HealthComponent
var hitbox: CollisionShape2D


## get reference to parent's components
func enter() -> void:
	health = parent.health
	hitbox = parent.hitbox
	
	GlobalScripts.verify(parent, health, "health")
	GlobalScripts.verify(parent, hitbox, "hitbox")

	GlobalScripts.connect_signal(parent, "area_entered", self, "_on_area_entered")
	GlobalScripts.connect_signal(health, "took_damage", self, "_on_took_damage")
	GlobalScripts.connect_signal(health, "health_zero", self, "_on_health_zero")


## TODO check health
func physics_process(delta: float) -> void:
	pass

## handles collisions with objective
func _on_area_entered(area: Area2D) -> void:
	if not current_state():
		return
	
	# if an enemy collides, take damage and delete it
	if area.is_in_group("enemies") and area.is_in_group("despawn_points"):
		var enemy = area.get_parent()
		enemy.queue_free()
		health.take_damage(enemy.damage.current_damage)


## handles taking damage
func _on_took_damage(damage: float, current_health: float) -> void:
	if not current_state():
		return
	
	# after taking damage, check to see if health is zero
	print("The objective took %s damage! Its health is now %s!" %[damage, current_health])
	health.check_health_zero()


## handles health reaching zero
func _on_health_zero() -> void:
	if not current_state():
		return
	
	# transition to die state
	# HACK might need to change the set_disabled method
	hitbox.set_disabled(true)
	transitioned.emit(self, "die")
