class_name Speed
extends Node

var parent: Node2D
var base_speed: float
var current_speed: float


## set speed values according to stats
func init(_parent: Node2D) -> void:
	parent = _parent
	base_speed = parent.stats.base_speed
	current_speed = base_speed
