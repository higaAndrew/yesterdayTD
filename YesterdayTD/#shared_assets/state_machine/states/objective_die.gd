class_name ObjectiveDie
extends State

var health: HealthComponent

## objective is destroyed
func enter() -> void:
	health = parent.health
	print("The objective is dead!")
	health.play_death_sound()
