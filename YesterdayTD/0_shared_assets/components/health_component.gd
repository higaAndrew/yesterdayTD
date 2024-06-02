class_name HealthComponent
extends Node

var parent: Node2D
var base_health: float
var current_health: float


## set health values according to stats
func init(_parent: Node2D) -> void:
	parent = _parent
	base_health = parent.stats.base_health
	current_health = base_health
