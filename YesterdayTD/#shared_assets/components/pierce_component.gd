class_name PierceComponent
extends Node

signal pierce_zero

@export var hitbox: CollisionShape2D

var parent: Area2D
var base_pierce: int
var current_pierce: int

var pierce_expended: bool


## set pierce values according to stats
func init(_parent: Area2D) -> void:
	parent = _parent
	base_pierce = parent.stats.base_pierce
	current_pierce = base_pierce
	pierce_expended = false


## reduce pierce. yup
func reduce_pierce() -> void:
	if not pierce_expended:
		current_pierce -= 1
		if current_pierce <= 0:
			pierce_expended = true
			pierce_zero.emit()
