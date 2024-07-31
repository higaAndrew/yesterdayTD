class_name HealthComponent
extends Node


signal healed(amount: float, current_health: float)
signal took_damage(amount: float, current_health: float)
signal health_depleted

@export var hitbox: CollisionShape2D

var parent: Area2D
var base_health: float
var current_health: float


## set health values according to stats
func init(_parent: Area2D) -> void:
	parent = _parent
	base_health = parent.stats.base_health
	current_health = base_health
	
	GlobalScripts.verify(parent, hitbox, "hitbox")


## increase health
func increase_health(amount: float) -> void:
	current_health += amount


## decrease health
func decrease_health(amount: float) -> void:
	current_health -= amount


## reset health
func reset_health() -> void:
	current_health = base_health


## restore health
func restore_health(amount: float) -> void:
	increase_health(-amount)
	healed.emit(amount, current_health)


## take damage and reduce health
func take_damage(amount: float) -> void:
	decrease_health(amount)
	took_damage.emit(amount, current_health)
	check_health_depleted()


## check if health is gone
func check_health_depleted() -> void:
	if max(0, current_health) == 0:
		health_depleted.emit()
