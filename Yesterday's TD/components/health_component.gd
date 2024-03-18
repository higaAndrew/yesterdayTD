class_name HealthComponent
extends Node2D

signal took_damage(current_health: float)
signal health_zero

@export var max_health := 100.00
@export var starting_health := max_health

var current_health


func initialize_health() -> void:
	# set starting health
	# if a starting health hasn't been set, just default to the max health
	if starting_health == 0:
		current_health = max_health
	else:
		current_health = starting_health


func take_damage(damage: float) -> void:
	# deal damage and subtract it from health
	# if health is below zero, set it to zero
	if current_health > 0.0:
		current_health -= damage
		took_damage.emit(current_health)
	elif current_health < 0.0:
		current_health = 0.0
		health_zero.emit()
