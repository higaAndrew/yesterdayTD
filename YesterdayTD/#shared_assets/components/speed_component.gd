class_name SpeedComponent
extends Node


var parent: Area2D
var base_speed: float
var current_speed: float


## set speed values according to stats
func init(_parent: Area2D) -> void:
	parent = _parent
	base_speed = parent.stats.base_speed
	current_speed = base_speed


## increase speed
func increase_speed(amount: float) -> void:
	current_speed += amount


## decrease speed
func decrease_speed(amount: float) -> void:
	current_speed -= amount


## reset speed
func reset_speed() -> void:
	current_speed = base_speed
