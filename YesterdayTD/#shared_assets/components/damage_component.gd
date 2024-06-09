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
func increase_damage(amount: float) -> void:
	current_damage += amount


## subtract damage
func decrease_damage(amount: float) -> void:
	current_damage -= amount


func reset_damage() -> void:
	current_damage = base_damage

## TODO mult/div damage
