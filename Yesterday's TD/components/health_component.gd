class_name HealthComponent
extends Node2D

signal took_damage(current_health: float)
signal health_zero
signal dead

@export var max_health: float
@export var starting_health := max_health

var current_health


func initialize() -> void:
	# set starting health
	# if a starting health hasn't been set, just default to the max health
	if starting_health == 0:
		current_health = max_health
		if max_health == 0:
			printerr("starting health cannot be zero!")
	else:
		current_health = starting_health


func take_damage(damage: float) -> void:
	# deal damage and subtract it from health
	# if health is below zero, set it to zero
	current_health -= damage
	took_damage.emit(current_health)
	print("ow")
	print(current_health)
	if max(0, current_health) == 0:
		health_zero.emit()
		die()


func die() -> void:
	dead.emit()
