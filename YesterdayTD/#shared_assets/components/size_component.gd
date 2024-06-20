class_name SizeComponent
extends Node


var parent: Area2D
var base_size: float
var current_size: float


## set size values according to stats
## then set the size
func init(_parent: Area2D) -> void:
	parent = _parent
	base_size = parent.stats.base_size
	current_size = base_size
	
	parent.scale = Vector2(current_size, current_size)


## add size
func increase_size(amount: float) -> void:
	current_size += amount


## subtract size
func decrease_size(amount: float) -> void:
	current_size -= amount


## multiply size
func multiply_size(amount: float) -> void:
	current_size *= amount


## divide size
func divide_size(amount: float) -> void:
	current_size /= amount


## restore size to base value
func reset_size() -> void:
	current_size = base_size
