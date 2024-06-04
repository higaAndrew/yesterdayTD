class_name SpeedComponent
extends Node

signal speed_changed(amount: float, current_speed: float)

var parent: Node2D
var base_speed: float
var current_speed: float


## set speed values according to stats
func init(_parent: Node2D) -> void:
	parent = _parent
	base_speed = parent.stats.base_speed
	current_speed = base_speed


## increase speed
func increase_speed(amount: float) -> void:
	current_speed += amount
	
	speed_changed.emit(amount, current_speed)


## decrease speed
func decrease_speed(amount: float) -> void:
	current_speed -= amount
	
	speed_changed.emit(amount, current_speed)
