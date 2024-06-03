class_name HealthComponent
extends Node

signal took_damage(damage: float, current_health: float)
signal health_zero

var parent: Node2D
var base_health: float
var current_health: float


## set health values according to stats
func init(_parent: Node2D) -> void:
	parent = _parent
	base_health = parent.stats.base_health
	current_health = base_health


func take_damage(damage: float) -> void:
	took_damage.emit(damage, current_health)
	current_health -= damage
	check_dead()


func check_dead() -> void:
	if max(0, current_health) == 0:
		health_zero.emit()
