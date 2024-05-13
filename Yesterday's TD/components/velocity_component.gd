class_name VelocityComponent
extends Node2D

@export var speed := 100


# set or change speed
func set_speed(new_speed: int) -> void:
	speed = new_speed
