class_name PierceComponent
extends Node

signal pierce_zero

var parent: Area2D
var base_pierce: int
var current_pierce: int


## set pierce values according to stats
func init(_parent: Area2D) -> void:
	parent = _parent
	base_pierce = parent.stats.base_pierce
	current_pierce = base_pierce


## reduce pierce. yup
func reduce_pierce() -> void:
	if current_pierce >= 1:
		current_pierce -= 1
	elif current_pierce <= 0:
		pierce_zero.emit()
