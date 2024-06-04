class_name DamageComponent
extends Node


var parent: Node2D
var base_damage: float
var current_damage: float


## set damage values according to stats
func init(_parent: Node2D) -> void:
	parent = _parent
	base_damage = parent.stats.base_damage
	current_damage = base_damage


## add damage
func increase_damage(modifier: float) -> void:
	current_damage += modifier


## subtract damage
func decrease_damage(modifier: float) -> void:
	current_damage -= modifier


## TODO mult/div damage
