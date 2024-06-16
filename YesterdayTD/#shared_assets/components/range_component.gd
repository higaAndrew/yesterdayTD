class_name RangeComponent
extends Node

signal range_updated(amount: float, current_range: float)

var parent: Area2D
var base_range: float
var current_range: float


## set range values according to stats
func init(_parent: Area2D) -> void:
	parent = _parent
	base_range = parent.stats.base_range
	current_range = base_range


## increase range
func increase_range(amount: float) -> void:
	current_range += amount
	range_updated.emit(amount, current_range)


## decrease range
func decrease_range(amount: float) -> void:
	current_range -= amount
	range_updated.emit(-amount, current_range)


## reset range
func reset_range() -> void:
	current_range = base_range
